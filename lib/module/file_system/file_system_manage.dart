import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../src/config/di/di.dart';
import '../../src/data/local/shared_preferences_manager.dart';
import '../../src/data/model/file_model.dart';
import '../../src/presentation/all_documents/cubit/base_cubit.dart';
import '../../src/presentation/all_documents/cubit/docs_cubit.dart';
import '../../src/presentation/all_documents/cubit/excel_cubit.dart';
import '../../src/presentation/all_documents/cubit/pdf_cubit.dart';
import '../../src/presentation/all_documents/cubit/ppt_cubit.dart';
import '../../src/presentation/document_tool/utils/pdf_util.dart';
import '../../src/shared/enum/app_enum.dart';
import '../../src/shared/helpers/permission_util.dart';
import 'enum/file_system_type.dart';

List<File> scanFilesInIsolate(String rootPath) {
  final result = <File>[];
  final rootDir = Directory(rootPath);

  final excludedPaths = [
    '/storage/emulated/0/Android',
    '/storage/emulated/0/Android/data',
    '/storage/emulated/0/Movies',
  ];

  if (!rootDir.existsSync()) return result;

  void safeScan(Directory dir) {
    // Nếu path nằm trong danh sách exclude → bỏ qua
    final skip = excludedPaths.any((p) => dir.path.startsWith(p));
    if (skip) {
      return;
    }

    try {
      final entities = dir.listSync(followLinks: false);
      for (final entity in entities) {
        if (entity is File) {
          result.add(entity);
        } else if (entity is Directory) {
          safeScan(entity); // đệ quy an toàn
        }
      }
    } catch (e) {
      // chỉ log, không crash isolate
      print('Error scanning ${dir.path}: $e');
    }
  }

  try {
    safeScan(rootDir);
  } catch (e) {
    print('Root scan failed: $e');
  }

  return result;
}

class FileSystemManager {
  FileSystemManager._();

  static FileSystemManager instance = FileSystemManager._();

  static const Map<FileSystemType, List<String>> _fileExtensions = {
    FileSystemType.pdf: ['.pdf'],
    FileSystemType.word: ['.doc', '.docx'],
    FileSystemType.excel: ['.xls', '.xlsx'],
    FileSystemType.ppt: ['.ppt', '.pptx'],
    FileSystemType.image: ['.jpg', '.jpeg', '.png', '.gif', '.bmp'],
  };

  Future<Directory?> getStorageDirectory() async {
    try {
      return Platform.isAndroid
          ? Directory('/storage/emulated/0/')
          : await getApplicationDocumentsDirectory();
    } catch (e) {
      debugPrint('Error fetching storage directory: $e');
      return null;
    }
  }

  Future<Directory?> getStorageDownload() async {
    try {
      if (Platform.isAndroid) {
        return Directory('/storage/emulated/0/Download');
      }
      return await getApplicationDocumentsDirectory();
    } catch (e) {
      debugPrint('Error fetching downloads directory: $e');
      return null;
    }
  }

  Future<void> getAllFiles({
    bool checkPermission = true,
  }) async {
    if (checkPermission &&
        !await PermissionUtil.instance.requestStoragePermission()) {
      return;
    }

    return Platform.isIOS ? null : await _getAndroidFiles();
  }

  Future<FileModel?> renameFile(FileModel file, String newName) async {
    final directory = path.dirname(file.file.path);
    final extension = path.extension(file.file.path).toLowerCase();

    try {
      if (!file.file.existsSync()) {
        debugPrint('Error: File does not exist at ${file.file.path}');
        return file;
      }

      final String? newPath = await _generateUniqueFilePath(
        directory: directory,
        fileName: newName,
        extension: extension,
      );
      if (newPath == null) {
        return null;
      }

      final File renamedFile = await file.file.rename(newPath);
      return file.copyWith(file: renamedFile);
    } catch (e) {
      debugPrint('Error renaming file: $e');
      return file;
    }
  }

  Future<bool> deleteListFile(List<File> files) async {
    final results = await Future.wait(files.map(deleteFile));
    return results.every((success) => success);
  }

  Future<bool> deleteFile(File file) async {
    try {
      if (!file.existsSync()) {
        return false;
      }
      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<TabBarType> getUniqueFileTypes(List<File> files) {
    return files.map(getTypeFile).toSet().toList();
  }

  TabBarType getTypeFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    return _getTabBarTypeFromExtension(extension);
  }

  Future<void> _getAndroidFiles() async {
    final Directory? storageDir = await getStorageDirectory();
    if (storageDir == null) {
      throw Exception('Storage directory not available');
    }

    try {
      // 🔹 Chạy isolate để quét file nền
      final files = await compute(scanFilesInIsolate, storageDir.path);
      await processFilesInBatches(files);
      return;
    } catch (e) {
      throw Exception('Failed to get Android files: $e');
    }
  }

  Future<String?> _generateUniqueFilePath({
    required String directory,
    required String fileName,
    required String extension,
  }) async {
    final String newPath = path.join(directory, '$fileName$extension');
    final File newFile = File(newPath);

    if (newFile.existsSync()) {
      // Nếu file đã tồn tại thì return null
      return null;
    }

    return newPath;
  }

  Future<void> processFilesInBatches(List<File> files) async {
    const batchSize = 10; // tùy thiết bị, có thể tăng lên 20-30
    for (var i = 0; i < files.length; i += batchSize) {
      final batch = files.skip(i).take(batchSize).toList();
      await Future.wait(batch.map(_addToCubitIfMatch));
    }
  }

  Future<void> _addToCubitIfMatch(File entity) async {
    try {
      final Map<FileSystemType, BaseFileCubit> _fileTypeToCubit = {
        FileSystemType.pdf: getIt<PdfCubit>(),
        FileSystemType.word: getIt<DocsCubit>(),
        FileSystemType.excel: getIt<ExcelCubit>(),
        FileSystemType.ppt: getIt<PptCubit>(),
      };
      final bookmarkedPaths = SharedPreferencesManager.instance.getSaveList();

      for (final entry in _fileTypeToCubit.entries) {
        final type = entry.key;
        final cubit = entry.value;

        if (_isFileTypeMatch(entity, type)) {
          final isBookmark = bookmarkedPaths.contains(entity.path);
          bool isLock = false;
          if (type == FileSystemType.pdf) {
            isLock = await PdfUtil.isPdfProtected(entity);
          }
          cubit.addFile(FileModel(
            id: const Uuid().v1(),
            file: entity,
            isBookmark: isBookmark,
            isLock: isLock,
          ));
        }
      }
    } catch (error) {
      debugPrint("error _addToCubitIfMatch:${entity.path} - $error");
    }
  }

  Future<void> _scanDirectory(Directory directory) async {
    try {
      await for (final entity
          in directory.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          _addToCubitIfMatch(entity);
        }
      }
    } catch (e) {
      debugPrint('Error scanning directory ${directory.path}: $e');
      return;
    }
  }

  bool _isFileTypeMatch(File file, FileSystemType fileType) {
    if (fileType == FileSystemType.all) {
      return true;
    }

    final extension = path.extension(file.path).toLowerCase();
    if (fileType == FileSystemType.others) {
      return !_fileExtensions.values.expand((x) => x).contains(extension);
    }

    return _fileExtensions[fileType]?.contains(extension) ?? false;
  }

  TabBarType _getTabBarTypeFromExtension(String extension) {
    final Map<String, TabBarType> extensionToType = {
      '.pdf': TabBarType.pdf,
      '.doc': TabBarType.word,
      '.docx': TabBarType.word,
      '.xls': TabBarType.excel,
      '.xlsx': TabBarType.excel,
      '.ppt': TabBarType.ppt,
      '.pptx': TabBarType.ppt,
    };

    return extensionToType[extension] ?? TabBarType.all;
  }
}
