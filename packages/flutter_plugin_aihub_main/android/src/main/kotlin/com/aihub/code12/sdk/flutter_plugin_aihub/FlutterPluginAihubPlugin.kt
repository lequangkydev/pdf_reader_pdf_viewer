package com.aihub.code12.sdk.flutter_plugin_aihub

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.code12.art.ArtPlugin
import com.code12.art.models.EditImageV3Request
import com.code12.art.models.PostApiTokenModel
import java.io.File

class FlutterPluginAihubPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: android.content.Context
    private var artPlugin: ArtPlugin? = null
    private var postApiTokenBody: PostApiTokenModel? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "flutter_plugin_aihub")
        channel.setMethodCallHandler(this)
        applicationContext = binding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> {
                val baseUrl = call.argument<String>("baseUrl")
                val appId = call.argument<String>("appId")
                val secretKey = call.argument<String>("secretKey")

                if (baseUrl == null || appId == null || secretKey == null) {
                    result.error("INVALID_ARGUMENT", "baseUrl, appId and secretKey are required", null)
                    return
                }

                artPlugin = ArtPlugin(
                    context = applicationContext,
                    baseUrl = baseUrl
                )

                postApiTokenBody = PostApiTokenModel(appId, secretKey)

                result.success(true)
            }

            "getApiToken" -> {
                val plugin = artPlugin
                val body = postApiTokenBody
                if (plugin == null || body == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                plugin.getApiTokenAsync(body) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        val tokenData = mapOf(
                            "token" to response?.data?.token,
                            "tokenExpire" to response?.data?.tokenExpire
                        )
                        result.success(tokenData)
                    }
                }
            }

            "editImageV3" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val uuid = call.argument<String>("uuid") ?: "123"
                val bodyMap = call.argument<Map<String, Any>>("body")

                if (token == null || bodyMap == null) {
                    result.error("INVALID_ARGUMENT", "token and body are required", null)
                    return
                }

                val body = EditImageV3Request.fromMap(bodyMap)

                plugin.editImageV3(body, token, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "uploadImage" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")

                if (token == null || filePath == null) {
                    result.error("INVALID_ARGUMENT", "token and filePath are required", null)
                    return
                }

                val file = File(filePath)

                plugin.uploadImage(file, token) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "editImageGhibliThemes" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val studio = call.argument<String>("studio")
                val uuid = call.argument<String>("uuid") ?: "123"

                if (token == null || filePath == null || studio == null) {
                    result.error("INVALID_ARGUMENT", "token, filePath, studio are required", null)
                    return
                }

                val file = File(filePath)

                plugin.editImageGhibliThemes(file, studio, token, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "editAnimeCharacter" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val animeCode = call.argument<String>("animeCode")
                val controlnetScale = call.argument<String>("controlnetConditioningScale")
                val uuid = call.argument<String>("uuid") ?: "123"

                if (token == null || filePath == null || animeCode == null || controlnetScale == null) {
                    result.error("INVALID_ARGUMENT", "token, filePath, animeCode, controlnetConditioningScale are required", null)
                    return
                }

                val file = File(filePath)

                plugin.editAnimeCharacter(file, animeCode, controlnetScale, token, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "editDressUp" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val uuid = call.argument<String>("uuid") ?: "123"
                val templateCode = call.argument<String>("templateCode")

                if (token == null || filePath == null || templateCode == null) {
                    result.error("INVALID_ARGUMENT", "token, filePath, and templateCode are required", null)
                    return
                }

                val file = File(filePath)

                plugin.editDressUp(file, templateCode, token, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "editFaceEnhancement" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val uuid = call.argument<String>("uuid") ?: "123"
                val faceUpsample = call.argument<Boolean>("faceUpsample")
                val detectionModel = call.argument<String>("detectionModel")
                val drawBox = call.argument<Boolean>("drawBox")
                val hasAligned = call.argument<Boolean>("hasAligned")
                val upscale = call.argument<Int>("upscale")
                val bgTile = call.argument<Int>("bgTile")
                val bgUpsamplerName = call.argument<String>("bgUpsamplerName")
                val onlyCenterFace = call.argument<Boolean>("onlyCenterFace")
                val fidelityWeight = call.argument<Double>("fidelityWeight")

                if (token == null || filePath == null) {
                    result.error("INVALID_ARGUMENT", "token and filePath are required", null)
                    return
                }

                val file = File(filePath)

                plugin.editFaceEnhancement(
                    file,
                    token,
                    faceUpsample,
                    detectionModel,
                    drawBox,
                    hasAligned,
                    upscale,
                    bgTile,
                    bgUpsamplerName,
                    onlyCenterFace,
                    fidelityWeight,
                    uuid
                ) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "removeBackground" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val uuid = call.argument<String>("uuid") ?: "123"
                val feature = call.argument<String>("feature")

                if (token == null || filePath == null) {
                    result.error("INVALID_ARGUMENT", "token and filePath are required", null)
                    return
                }

                val file = File(filePath)

                plugin.removeBackground(file, token, feature, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "createFusionMerge" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val code = call.argument<String>("code")
                val uuid = call.argument<String>("uuid") ?: "123"

                if (token == null || filePath == null || code == null) {
                    result.error("INVALID_ARGUMENT", "token, filePath and code are required", null)
                    return
                }

                val file = File(filePath)

                plugin.createFusionMerge(file, code, token, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "enhanceImage" -> {
                val plugin = artPlugin
                if (plugin == null) {
                    result.error("NOT_INITIALIZED", "Call init first", null)
                    return
                }

                val token = call.argument<String>("token")
                val filePath = call.argument<String>("filePath")
                val uuid = call.argument<String>("uuid") ?: "123"
                val feature = call.argument<String>("feature")
                val maskFilePath = call.argument<String>("maskFilePath") ?: null
                if (token == null || filePath == null) {
                    result.error("INVALID_ARGUMENT", "token and filePath are required", null)
                    return
                }

                val file = File(filePath)
                val maskFile = File(maskFilePath)
                plugin.enhanceImage(file, token, maskFile, feature, uuid) { response, error ->
                    if (error != null) {
                        result.error("API_ERROR", error.message, null)
                    } else {
                        result.success(response?.toMap())
                    }
                }
            }

            "pdfSummary" -> {
    val plugin = artPlugin
    if (plugin == null) {
        result.error("NOT_INITIALIZED", "Call init first", null)
        return
    }

    val token = call.argument<String>("token")
    val filePath = call.argument<String>("filePath")
    val uuid = call.argument<String>("uuid") ?: "1212"
    val language = call.argument<String>("language")
    val summaryType = call.argument<String>("summaryType")
    val action = call.argument<String>("action")

    if (token == null || filePath == null || language == null || summaryType == null || action == null) {
        result.error("INVALID_ARGUMENT", "token, filePath, language, summaryType, action are required", null)
        return
    }

    val file = File(filePath)

    plugin.pdfSummary(file, token, language, summaryType, action, uuid) { response, error ->
        if (error != null) {
            result.error("API_ERROR", error.message, null)
        } else {
            result.success(response?.toMap())
        }
    }
}

"tryOnHuggingFace" -> {
    val plugin = artPlugin
    if (plugin == null) {
        result.error("NOT_INITIALIZED", "Call init first", null)
        return
    }

    val token = call.argument<String>("token")
    val fileFirstPath = call.argument<String>("fileFirstPath")
    val fileSecondPath = call.argument<String>("fileSecondPath")
    val uuid = call.argument<String>("uuid") ?: "123"
    val code = call.argument<String>("code") ?: "HUGGING"
    val context = call.argument<String>("context") ?: "studio"

    if (token == null || fileFirstPath == null || fileSecondPath == null) {
        result.error("INVALID_ARGUMENT", "token, fileFirstPath and fileSecondPath are required", null)
        return
    }

    val fileFirst = File(fileFirstPath)
    val fileSecond = File(fileSecondPath)

    plugin.tryOnHuggingFace(fileFirst, fileSecond, token, code, context, uuid) { response, error ->
        if (error != null) {
            result.error("API_ERROR", error.message, null)
        } else {
            result.success(response?.toMap())
        }
    }
}

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        artPlugin = null
        postApiTokenBody = null
    }
}
