package com.vtn.global.base.flutter.utils

import android.Manifest
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.FileObserver
import android.webkit.MimeTypeMap
import androidx.annotation.RequiresPermission
import com.vtn.global.base.flutter.MainActivity
import com.vtn.global.base.flutter.R
import java.io.File


class RecursiveFileObserver(
    private val rootPath: String,
    private val context: Context,
    private val eventName: String? = null,
) {

    private val observers = mutableListOf<FileObserver>()

    fun startWatching() {
        observeDirectory(File(rootPath))
    }

    private fun observeDirectory(dir: File) {
        if (!dir.exists() || !dir.isDirectory) return

        val observer = DownloadFileObserver(dir.absolutePath, context, eventName = eventName)
        observer.startWatching()
        observers.add(observer)

        // Đệ quy cho tất cả thư mục con
        dir.listFiles()?.forEach {
            if (it.isDirectory) {
                observeDirectory(it)
            }
        }
    }

    fun stopWatching() {
        try {
            observers.forEach { it.stopWatching() }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        observers.clear()
    }

    inner class DownloadFileObserver(
        private val downloadPath: String,
        private val context: Context,
        private val eventName: String? = null,
    ) :
        FileObserver(downloadPath, ALL_EVENTS) {

        private fun handleFileName(fileName: String): String {
            if (fileName.contains("pending")) {
                // file tải từ browser
                return fileName.split("-").let {
                    it.subList(2, it.size).joinToString("-")
                }
            } else if (downloadPath.contains("Messenger")) {
                // file tải từ messenger
                // do messenger tải ảnh về có đuôi .jpg sau đó đổi lại sang jpeg
                return fileName.replace(".jpg", ".jpeg")
            }
            return fileName
        }

        @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
        override fun onEvent(event: Int, path: String?) {
            if (path != null && event == CREATE) {
                if (File("$downloadPath/$path").isDirectory) {
                    this@RecursiveFileObserver.observeDirectory(File("$downloadPath/$path"))
                    return
                }
                val fileName: String = handleFileName(path)
                val file = File("$downloadPath/$fileName")
                // Intent khi người dùng nhấn vào thông báo
                val intent = Intent(context, MainActivity::class.java)
                intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
                intent.putExtra("filePath", file.absolutePath)
                intent.putExtra("isNewFile", true)
                intent.putExtra("eventName", eventName)
                val requestCode = System.currentTimeMillis().toInt()
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    requestCode,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                val mimeType = getMimeType(fileName) ?: return
                if (fileName.startsWith(".tmp")) {
                    return
                }
                val newFileTitles = NotificationUtil.remoteNotification?.newFile;
                val title = when {
                    mimeType.isPdf -> newFileTitles?.pdf
                        ?: context.getString(R.string.you_have_a_new_pdf_file)

                    mimeType.isWord -> newFileTitles?.word
                        ?: context.getString(R.string.you_have_a_new_word_file)

                    mimeType.isExcel -> newFileTitles?.excel
                        ?: context.getString(R.string.you_have_a_new_excel_file)

                    mimeType.isPowerPoint -> newFileTitles?.ppt
                        ?: context.getString(R.string.you_have_a_new_ppt_file)

                    mimeType.isImage -> newFileTitles?.photo
                        ?: context.getString(R.string.you_have_a_new_photo)

                    else -> null
                }
                val notificationId = when {
                    mimeType.isPdf -> NotificationUtil.PDF_NOTIFICATION_ID
                    mimeType.isWord -> NotificationUtil.DOC_NOTIFICATION_ID
                    mimeType.isExcel -> NotificationUtil.XLS_NOTIFICATION_ID
                    mimeType.isPowerPoint -> NotificationUtil.PPT_NOTIFICATION_ID
                    mimeType.isImage -> NotificationUtil.IMAGE_NOTIFICATION_ID
                    else -> null
                }
                if (title == null || notificationId == null) {
                    return
                }
                if (eventName != null) {
                    AnalyticLoggerUtil.logNotifyEvent(context, "show_$eventName")
                }
                NotificationUtil.showNotification(
                    context,
                    notificationId = notificationId,
                    title = title,
                    message = fileName,
                    pendingIntent = pendingIntent,
                )
            }
        }

        private fun getMimeType(fileName: String): String? {
            val extension = fileName.substringAfterLast('.', "").lowercase()
            return MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
        }
    }
}