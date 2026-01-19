-keep class com.ahmadullahpk.alldocumentreader.xs.** { *; }
-keep class java.io.**
-keep class com.facebook.** { *; }
-keepclassmembers class com.facebook.** { *; }
-dontwarn com.facebook.**
##############################################
# 🔒 AIHub Flutter Plugin - Native side
##############################################

# Giữ toàn bộ class & method trong plugin Flutter (Kotlin side)
-keep class com.aihub.code12.sdk.flutter_plugin_aihub.** { *; }
-keepnames class com.aihub.code12.sdk.flutter_plugin_aihub.** { *; }
-dontwarn com.aihub.code12.sdk.flutter_plugin_aihub.**

# Giữ lại SDK gốc (lib-release)
-keep class com.aihub.** { *; }
-keepnames class com.aihub.** { *; }
-dontwarn com.aihub.**

# Giữ lại các class ART SDK mà plugin gọi đến
-keep class com.code12.art.** { *; }
-dontwarn com.code12.art.**

# Retrofit / Gson / OkHttp (vì ART SDK chắc chắn dùng)
-keepattributes Signature, InnerClasses, *Annotation*
-keep class retrofit2.** { *; }
-keep interface retrofit2.** { *; }
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**

# Giữ lớp Flutter Embedding (để FlutterEngine / MethodChannel không bị xoá)
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-dontwarn io.flutter.**

# Giữ lại PlayCore (để tránh lỗi SplitInstall... Missing)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
