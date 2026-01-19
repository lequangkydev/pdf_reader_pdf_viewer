import 'dart:io';

//dart run tool/clean_unused_assets.dart
void main() {
  final assetFiles = _getAssetFiles();
  final usedAssets = <String>[];
  final unusedAssets = <String>[];

  // Đọc toàn bộ content của tất cả dart files
  final allDartContent = _getAllDartContent();

  for (final asset in assetFiles) {
    final assetName = _getAssetNameFromPath(asset);
    final camelCaseName = _snakeToCamelCase(assetName);

    // Tìm bằng cả camelCase và snake_case
    final isUsed = allDartContent.contains(camelCaseName) ||
        allDartContent.contains(assetName);

    if (isUsed) {
      usedAssets.add(asset);
    } else {
      unusedAssets.add(asset);
    }
  }

  print('✅ ASSETS ĐƯỢC DÙNG (${usedAssets.length}):');
  usedAssets.forEach((asset) => print('• $asset'));

  print('\n❌ ASSETS KHÔNG DÙNG (${unusedAssets.length}):');
  unusedAssets.forEach((asset) => print('• $asset'));
}

List<String> _getAssetFiles() {
  final assetsDir = Directory('assets');
  if (!assetsDir.existsSync()) return [];
  return assetsDir
      .listSync(recursive: true)
      .whereType<File>()
      .map((file) => file.path.replaceAll('\\', '/'))
      .where((path) => path.contains('assets/'))
      .map((path) => path.split('assets/').last)
      .toList();
}

String _getAllDartContent() {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) return '';

  final content = StringBuffer();
  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.contains('assets.gen.dart')) {
      content.writeln(entity.readAsStringSync());
    }
  }
  return content.toString();
}

String _getAssetNameFromPath(String assetPath) {
  return assetPath.split('/').last.split('.').first;
}

String _snakeToCamelCase(String snakeCase) {
  final parts = snakeCase.split('_');
  if (parts.length == 1) return parts[0];
  final result = StringBuffer(parts[0]);
  for (int i = 1; i < parts.length; i++) {
    if (parts[i].isNotEmpty) {
      result.write(parts[i][0].toUpperCase() + parts[i].substring(1));
    }
  }
  return result.toString();
}
