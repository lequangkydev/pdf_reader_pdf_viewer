#!/bin/bash
set -e

OUTPUT_DIR="release_build"
DEBUG_INFO_DIR="debug_info"

# 1. Dọn sạch build cũ
rm -rf $OUTPUT_DIR
rm -rf build
mkdir -p $OUTPUT_DIR
mkdir -p $DEBUG_INFO_DIR

echo "🚀 Obfuscating Dart lib..."

# 2. Build obfuscate (tạo ra lib đã tối ưu)
flutter build apk --obfuscate --split-debug-info=$DEBUG_INFO_DIR

# 3. Copy source lib (đã obfuscate) + pubspec vào release
cp -r lib $OUTPUT_DIR/lib
cp pubspec.yaml $OUTPUT_DIR/
cp README.md $OUTPUT_DIR/ || true
cp CHANGELOG.md $OUTPUT_DIR/ || true
cp -r android $OUTPUT_DIR/android
cp -r ios $OUTPUT_DIR/ios

echo "✅ Obfuscate xong, release folder: $OUTPUT_DIR"

# 4. Commit vào branch release
git checkout -B release
git add $OUTPUT_DIR
git commit -m "Release obfuscated plugin"
git push origin release --force

echo "🎉 Branch 'release' sẵn sàng share cho khách."
echo "⚠️ Giữ thư mục $DEBUG_INFO_DIR để debug stacktrace."
