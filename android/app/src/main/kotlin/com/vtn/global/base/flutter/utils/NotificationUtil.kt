package com.vtn.global.base.flutter.utils

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import androidx.annotation.RequiresPermission
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.vtn.global.base.flutter.MainActivity
import com.vtn.global.base.flutter.R
import com.vtn.global.base.flutter.model.NotificationModel
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object NotificationUtil {
    var remoteNotification: NotificationModel? = null

    private const val RECENT_ACTION = "openRecent"
    private const val HOME_ACTION = "openHome"
    private const val BOOKMARK_ACTION = "openBookmark"
    private const val TOOL_ACTION = "openTool"

    const val KILL_APP_NOTIFICATION_ID = 109
    const val EXIT_APP_NOTIFICATION_ID = 200
    const val PDF_NOTIFICATION_ID = 201
    const val DOC_NOTIFICATION_ID = 202
    const val XLS_NOTIFICATION_ID = 203
    const val PPT_NOTIFICATION_ID = 204
    const val IMAGE_NOTIFICATION_ID = 205
    const val OFFICE_NOTIFICATION_ID = 206

    private fun isDarkTheme(activity: Context): Boolean {
        return activity.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK == Configuration.UI_MODE_NIGHT_YES
    }

    private fun isEnableNotification(context: Context): Boolean {
        if (!AppConstant.isFullAds) {
            return false
        }
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }


    private fun setupAppInfo(
        context: Context,
        remoteView: RemoteViews,
    ) {
        val appName = context.getString(R.string.app_name)
        val textColor = if (isDarkTheme(context)) ContextCompat.getColor(
            context,
            R.color.white
        ) else ContextCompat.getColor(context, R.color.notificationText)
        val time = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date())
        remoteView.setTextViewText(R.id.app_name, appName)
        remoteView.setTextViewText(R.id.time, time)
        remoteView.setTextColor(R.id.app_name, textColor)
        remoteView.setTextColor(R.id.time, textColor)
        remoteView.setTextColor(R.id.dot, textColor)
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    internal fun showNotification(
        context: Context,
        notificationId: Int,
        title: String,
        message: String,
        eventName: String? = null,
        pendingIntent: PendingIntent,
    ) {
        if (!isEnableNotification(context)) {
            return
        }
        val channelId = "default_channel_id"

        // Hủy thông báo cũ
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
        notificationManager?.cancel(notificationId)
        // Tạo kênh thông báo
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId, "Default Channel", NotificationManager.IMPORTANCE_HIGH
            )
            val manager = context.getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }

        // Tạo thông báo
        val notification = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.ic_notification) // Notificat
            .setContentTitle(title)
            .setContentText(message)
            .setPriority(NotificationCompat.PRIORITY_HIGH) // High priority
            .setAutoCancel(true) // Auto cancel on click
            .setContentIntent(pendingIntent)

        // Hiển thị thông báo
        NotificationManagerCompat.from(context).notify(notificationId, notification.build())

        if (eventName != null) {
            AnalyticLoggerUtil.logNotifyEvent(context, "show_$eventName")
        }
    }


    // Tạo intent cho các nút trong thông báo
    private fun createActionPendingIntent(
        context: Context, actionKey: String, requestCode: Int
    ): PendingIntent {
        val intent = Intent(context, MainActivity::class.java).apply {
            putExtra("notification_action", actionKey)
            putExtra("eventName", "actionKey")
            flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP // Thêm flags
        }
        return PendingIntent.getActivity(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    // Tạo remote view cho các nút trong thông báo
    private fun createFunctionRemoteView(
        context: Context, layoutId: Int
    ): RemoteViews {
        val homePendingIntent = createActionPendingIntent(context, HOME_ACTION, 11)
        val recentPendingIntent = createActionPendingIntent(context, RECENT_ACTION, 12)
        val bookmarkPendingIntent = createActionPendingIntent(context, BOOKMARK_ACTION, 13)
        val toolPendingIntent = createActionPendingIntent(context, TOOL_ACTION, 14)

        val remoteView = RemoteViews(context.packageName, layoutId)

        remoteView.setOnClickPendingIntent(R.id.homeButton, homePendingIntent)
        remoteView.setOnClickPendingIntent(R.id.recentButton, recentPendingIntent)
        remoteView.setOnClickPendingIntent(R.id.bookmarkButton, bookmarkPendingIntent)
        remoteView.setOnClickPendingIntent(R.id.toolButton, toolPendingIntent)
        return remoteView
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    internal fun showFunctionNotification(
        context: Context
    ) {
        if (!isEnableNotification(context)) {
            return
        }
        val channelId = "default_channel_id"
        // Hủy thông báo cũ
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
        notificationManager?.cancel(100)
        // Tạo kênh thông báo
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId, "Default Channel", NotificationManager.IMPORTANCE_HIGH
            )
            val manager = context.getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)

        }
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra("eventName", "function_notification")
        }
        val pendingIntent = PendingIntent.getActivity(
            context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        // Tạo custom view cho thông báo thu gọn
        val customView = createFunctionRemoteView(context, R.layout.function_notification_collapse)
        // Tạo custom view cho thông báo mở rộng
        val subtitleColor = if (isDarkTheme(context)) ContextCompat.getColor(
            context,
            R.color.white
        ) else ContextCompat.getColor(context, R.color.notificationText)
        val customBigView = createFunctionRemoteView(context, R.layout.function_notification_expand)
        customBigView.setTextColor(R.id.allFiles, subtitleColor)
        customBigView.setTextColor(R.id.recentText, subtitleColor)
        customBigView.setTextColor(R.id.bookmarkText, subtitleColor)
        customBigView.setTextColor(R.id.toolText, subtitleColor)
        customBigView.setTextViewText(R.id.allFiles, context.getString(R.string.all_files))
        customBigView.setTextViewText(R.id.recentText, context.getString(R.string.recent))
        customBigView.setTextViewText(R.id.bookmarkText, context.getString(R.string.bookmark))
        customBigView.setTextViewText(R.id.toolText, context.getString(R.string.tool))

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            customView.setViewVisibility(R.id.appInfo, View.VISIBLE)
            customBigView.setViewVisibility(R.id.appInfo, View.VISIBLE)
            setupAppInfo(context, customView)
            setupAppInfo(context, customBigView)
            customView.setViewPadding(R.id.layout_notification, 14, 10, 14, 10)
            customBigView.setViewPadding(R.id.layout_notification, 14, 10, 14, 10)
        }

        // Tạo thông báo
        val notification = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.ic_pdf) // Biểu tượng thông báo
            .setCustomContentView(customView).setCustomBigContentView(customBigView)
            .setPriority(NotificationCompat.PRIORITY_HIGH) // Độ ưu tiên cao
            .setSilent(true).setContentIntent(pendingIntent) // Intent khi nhấn vào thông báo
            .setOngoing(true).build()
        NotificationManagerCompat.from(context).notify(100, notification)
    }


    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    fun showRecentFileNotification(
        context: Context,
        eventName: String? = null,
    ) {
        if (!isEnableNotification(context)) {
            return
        }
        if (AppConstant.blockRecentFileNotification) {
            return
        }
        // Tạo intent cho nút mở tệp gần đây
        val intent = Intent(context, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
        var recentFilePath = SharedPreferencesUtil(context).getRecentFile()
        if (recentFilePath.isNullOrEmpty()) {
            recentFilePath = context.filesDir.absolutePath.split('/').let {
                it.subList(0, it.size - 1).joinToString("/")
            } + "/app_flutter/sample.pdf"
        }
        intent.putExtra("filePath", recentFilePath)
        intent.putExtra("eventName", eventName)
        val requestCode = System.currentTimeMillis().toInt()
        val pendingIntent = PendingIntent.getActivity(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        if (eventName != null) {
            AnalyticLoggerUtil.logNotifyEvent(context, "show_$eventName")
        }
        val recentContent = remoteNotification?.recent
        // Tạo thông báo
        showNotification(
            context,
            notificationId = EXIT_APP_NOTIFICATION_ID,
            title = recentContent?.title ?: context.getString(R.string.unread_document_file),
            message = recentContent?.message ?: context.getString(R.string.unfinished_reading_file),
            pendingIntent = pendingIntent,
        )
    }
}