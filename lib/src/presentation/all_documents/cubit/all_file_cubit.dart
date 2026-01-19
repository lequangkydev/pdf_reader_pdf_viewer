import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../module/file_system/file_system_manage.dart';
import '../../../config/di/di.dart';
import '../../../data/model/file_model.dart';
import '../../../shared/helpers/permission_util.dart';
import 'base_cubit.dart';
import 'docs_cubit.dart';
import 'excel_cubit.dart';
import 'pdf_cubit.dart';
import 'ppt_cubit.dart';

@singleton
class AllFileCubit extends BaseFileCubit {
  AllFileCubit() : super() {
    _subscriptions = [
      getIt<PdfCubit>().stream.listen((_) => _mergeStates()),
      getIt<DocsCubit>().stream.listen((_) => _mergeStates()),
      getIt<ExcelCubit>().stream.listen((_) => _mergeStates()),
      getIt<PptCubit>().stream.listen((_) => _mergeStates()),
    ];
  }

  late final List<StreamSubscription> _subscriptions;

  void _mergeStates() {
    final allFiles = [
      ...getIt<PdfCubit>().state,
      ...getIt<DocsCubit>().state,
      ...getIt<ExcelCubit>().state,
      ...getIt<PptCubit>().state,
    ];
    // Lọc trùng theo path
    final uniqueFiles = <String, FileModel>{};
    for (final file in allFiles) {
      uniqueFiles[file.file.path] = file;
    }
    emit(uniqueFiles.values.toList());
  }

  Future<void> initAll() async {
    final status = await PermissionUtil.instance.checkStoragePermission();
    if (!status) {
      return;
    }
    getIt<AllFileCubit>().clear();
    getIt<PdfCubit>().clear();
    getIt<DocsCubit>().clear();
    getIt<ExcelCubit>().clear();
    getIt<PptCubit>().clear();
    await FileSystemManager.instance.getAllFiles(checkPermission: false);

    _mergeStates();
  }

  DateTime? _lastReloadTime;

  Future<void> reloadFile() async {
    final now = DateTime.now();
    if (_lastReloadTime != null &&
        now.difference(_lastReloadTime!).inSeconds < 5) {
      return;
    }
    _lastReloadTime = now;

    final status = await PermissionUtil.instance.checkStoragePermission();
    if (!status) return;
    await initAll();
  }

  @override
  Future<void> close() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    return super.close();
  }
}
