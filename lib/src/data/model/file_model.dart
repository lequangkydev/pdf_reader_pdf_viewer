import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'file_model.freezed.dart';
part 'file_model.g.dart';

@freezed
class FileModel with _$FileModel {
  const factory FileModel({
    required String id,
    @FileConverter() required File file,
    @Default(false) bool isSelect,
    @Default(false) bool isLock,
    @Default(false) bool isBookmark,
  }) = _FileModel;

  factory FileModel.create({
    required File file,
  }) {
    return FileModel(
      id: const Uuid().v4(),
      file: file,
    );
  }

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);
}

/// Converter để hỗ trợ lưu/đọc File path thay vì object File
class FileConverter implements JsonConverter<File, String> {
  const FileConverter();

  @override
  File fromJson(String path) => File(path);

  @override
  String toJson(File file) => file.path;
}
