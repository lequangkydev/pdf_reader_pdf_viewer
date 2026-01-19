# flutter_plugin_aihub

Plugin Flutter giúp bạn tích hợp nhanh với **AIHub SDK** (khởi tạo, refresh token, upload và chỉnh sửa ảnh, …).

---

## 🚀 Getting Started

```bash
make regen
```

Thêm mavenLocal() vào build.gradle:

```bash
build.gradle -> allprojects {
repositories {
mavenLocal() <-- Add to first
google()
mavenCentral()
}
}
```

### 1. Initialize SDK

Trước khi sử dụng, bạn cần gọi hàm `init` với `appId`, `secretKey` và `baseUrl` .

```bash
bool isInit = await FlutterPluginAihub.init(
baseUrl: "",
appId: "",
secretKey: "",
);
final tokenData = await FlutterPluginAihub.getApiToken();
token = tokenData?["token"];
```

2. Refresh Token
   Khi token hết hạn, chỉ cần gọi lại hàm:

```bash
final tokenData = await FlutterPluginAihub.getApiToken();
token = tokenData?["token"];
```

3. Gọi API qua SDK
   Hiện tại plugin đã expose các API sau:

```bash
editImageV3(
token: token,
body: {
"imageId": …,
"attributes": [
{
"studioId": …,
"featureId": …,
"styleId": …,
},
],
},
);
```

```bash
uploadImage({
required String token,
required File file,
});
```

```bash
editImageGhibliThemes({
required String token,
required File file,
required String studio,
});
```

```bash
editAnimeCharacter({
required String token,
required File file,
required String animeCode,
required double controlnetConditioningScale,
});
```

```bash
editDressUp({
required String token,
required File file,
required String templateCode,
});
```

```bash
editFaceEnhancement({
required String token,
required File file,
bool? faceUpsample,
String? detectionModel,
bool? drawBox,
bool? hasAligned,
int? upscale,
int? bgTile,
String? bgUpsamplerName,
bool? onlyCenterFace,
double? fidelityWeight,
});

```

```bash
removeBackground({
required String token,
required File file,
String? feature, // Ex: {"feature":"BACKGROUND_REMOVAL","options":{"image_type":"general"}}
});
```

```bash
createFusionMerge({
required String token,
required File file,
required String code,
});
```

```bash
enhanceImage({
required String token,
required File file,
String? feature, // EX: {"feature":"IMAGE_ENHANCE","options":{"scale":"2","brightness":"1.5","contrast":"1.5","saturation":"1.5","sharpness":"1.5","denoise":"true"}}
})
```

```bash
pdfSummary({
required String token,
required File file,
language= "english",
summaryType= "INFORMATIVE",
action= "SUMMARIZE",
})
```

```bash
tryOnHuggingFace(
{
required String token,
required File fileFirst,
required File fileSecond,
code= "HUGGING",
context = "studio",
}
)

```

📌 To be updated
README sẽ được cập nhật thêm khi plugin bổ sung tính năng mới.
