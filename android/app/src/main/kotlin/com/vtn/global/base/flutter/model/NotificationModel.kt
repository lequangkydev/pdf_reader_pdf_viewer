package com.vtn.global.base.flutter.model

data class NotificationModel(
    val newFile: NewFile? = null,
    val recent: NotificationBaseContent? = null,
    val killApp: NotificationBaseContent? = null
) {
    companion object {
        fun fromJson(json: Map<*, *>): NotificationModel {
            val newFile = (json["new_file"] as? Map<*, *>)?.let { NewFile.fromJson(it) }
            val recent =
                (json["recent"] as? Map<*, *>)?.let { NotificationBaseContent.fromJson(it) }
            val killApp =
                (json["kill_app"] as? Map<*, *>)?.let { NotificationBaseContent.fromJson(it) }
            return NotificationModel(newFile, recent, killApp)
        }
    }

    fun toJson(): Map<String, Any?> = mapOf(
        "new_file" to newFile?.toJson(),
        "recent" to recent?.toJson(),
        "kill_app" to killApp?.toJson()
    )
}

data class NewFile(
    val pdf: String? = null,
    val word: String? = null,
    val excel: String? = null,
    val ppt: String? = null,
    val photo: String? = null
) {
    companion object {
        fun fromJson(json: Map<*, *>): NewFile {
            return NewFile(
                pdf = json["pdf"] as? String,
                word = json["word"] as? String,
                excel = json["excel"] as? String,
                ppt = json["ppt"] as? String,
                photo = json["photo"] as? String
            )
        }
    }

    fun toJson(): Map<String, Any?> = mapOf(
        "pdf" to pdf,
        "word" to word,
        "excel" to excel,
        "ppt" to ppt,
        "photo" to photo
    )
}

data class NotificationBaseContent(
    val title: String? = null,
    val message: String? = null
) {
    companion object {
        fun fromJson(json: Map<*, *>): NotificationBaseContent {
            return NotificationBaseContent(
                title = json["title"] as? String,
                message = json["message"] as? String
            )
        }
    }

    fun toJson(): Map<String, Any?> = mapOf(
        "title" to title,
        "message" to message
    )
}
