import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'file_system_manage.dart';

class FilePathManager {
  FilePathManager._();

  static FilePathManager instance = FilePathManager._();

  Future<bool> isFileInAppCache(String filePath) async {
    final cacheDir = await getTemporaryDirectory();
    return filePath.startsWith(cacheDir.path);
  }

  /// Saves bytes data to downloads directory
  Future<String> saveBytesToDownloads(List<int> bytes, String fileName,
      {String? extension}) async {
    final Directory? downloadsDir = await _getDownloadsDirectory();
    _validateDirectory(downloadsDir);

    try {
      final file = File(path.join(downloadsDir!.path, fileName));
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    } catch (e) {
      throw Exception('Failed to save bytes to downloads: $e');
    }
  }

  /// Saves file from cache to downloads directory
  Future<String> saveFileToDownloads(
      String cacheFilePath, String newFilePath) async {
    final Directory? directory = await _getDownloadsDirectory();
    _validateDirectory(directory);

    try {
      final file = File(path.join(directory!.path, newFilePath));
      final File sourceFile = File(Uri.parse(cacheFilePath).toFilePath());

      if (!sourceFile.existsSync()) {
        throw Exception('Source file does not exist');
      }

      final List<int> bytes = await sourceFile.readAsBytes();
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    } catch (e) {
      throw Exception('Failed to save file to downloads: $e');
    }
  }

  /// Saves Uint8List as image file
  Future<File?> saveUint8ListToImage(
      Uint8List imageBytes, String fileName) async {
    if (!Platform.isAndroid) {
      return null;
    }

    try {
      final Directory downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        throw Exception('Downloads directory does not exist');
      }

      final file = File(path.join(downloadsDir.path, '$fileName.png'));
      return await file.writeAsBytes(imageBytes, flush: true);
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  /// Picks multiple files (iOS only)
  Future<List<File>?> pickMultipleFiles(List<String> extensions) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: extensions,
      );

      if (result == null) {
        return null; // User cancelled
      }

      final List<File> files = result.paths
          .where((path) => path != null)
          .map((path) => File(path!))
          .toList();

      await Future.wait(files.map((file) => savePickedFile(file)));
      return files;
    } catch (e) {
      throw Exception('Failed to pick files: $e');
    }
  }

  /// Saves picked file to app's cache directory (iOS only)
  Future<void> savePickedFile(File file) async {
    final Directory? appDocDir = await _getStorageDirectory();
    if (appDocDir == null) {
      throw Exception('App document directory not available');
    }

    try {
      final String fileName = path.basename(file.path);
      final File newFile = File(path.join(appDocDir.path, fileName));
      await newFile.writeAsBytes(await file.readAsBytes());
    } catch (e) {
      throw Exception('Failed to save picked file: $e');
    }
  }

  Future<Directory?> _getDownloadsDirectory() async {
    return FileSystemManager.instance.getStorageDownload();
  }

  Future<Directory?> _getStorageDirectory() async {
    return FileSystemManager.instance.getStorageDirectory();
  }

  void _validateDirectory(Directory? directory) {
    if (directory == null || !directory.existsSync()) {
      throw Exception('Directory does not exist or is not accessible');
    }
  }

  Future<File?> saveLocalImage(Uint8List imageBytes, String fileName) async {
    final result = await ImageGallerySaverPlus.saveImage(
      imageBytes,
      name: fileName,
    );

    // Kết quả trả về là Map<String, dynamic>
    print("Save result: $result");

    final isSuccess = result['isSuccess'] == true;
    final filePath = result['filePath'] as String?;

    if (isSuccess && filePath != null) {
      // Một số Android trả dạng "content://", bạn cần convert sang File path thật
      if (filePath.startsWith('content://')) {
        // 👉 cần thư viện extra để truy xuất thực file path nếu cần
        return null; // hoặc xử lý theo ý bạn
      }

      final file = File(filePath);
      return file;
    }

    return null;
  }
}
