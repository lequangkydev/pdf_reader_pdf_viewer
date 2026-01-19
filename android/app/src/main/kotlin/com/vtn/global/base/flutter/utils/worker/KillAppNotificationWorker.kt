package com.vtn.global.base.flutter.utils.worker

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.annotation.RequiresPermission
import androidx.core.app.NotificationCompat
import androidx.work.ForegroundInfo
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import androidx.work.workDataOf
import com.vtn.global.base.flutter.MainActivity
import com.vtn.global.base.flutter.R
import com.vtn.global.base.flutter.utils.AnalyticLoggerUtil
import com.vtn.global.base.flutter.utils.AppConstant
import com.vtn.global.base.flutter.utils.NotificationUtil
import java.util.concurrent.TimeUnit

class KillAppNotificationWorker(private val context: Context, workerParams: WorkerParameters) :
    Worker(context, workerParams) {
    companion object {
        fun scheduleUniqueWork(
            context: Context,
            uniqueWorkName: String,
            eventName: String,
            duration: Long,
            unit: TimeUnit,
            tag: String? = null
        ) {
            val data = workDataOf(
                "eventName" to eventName,
            )

            val worker = OneTimeWorkRequestBuilder<KillAppNotificationWorker>()
                .setInitialDelay(
                    duration,
                    unit
                )
                .setInputData(data)
            if (tag != null) {
                worker.addTag(tag)
            }
            val workRequest = worker.build()
            WorkManager.getInstance(context).enqueueUniqueWork(
                uniqueWorkName,
                androidx.work.ExistingWorkPolicy.REPLACE,
                workRequest
            )
        }
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    override fun doWork(): Result {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createForegroundInfo()
        }
        val eventName = inputData.getString("eventName")

        val intent = Intent(applicationContext, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
        intent.putExtra("filePath", AppConstant.recentFilePath)

        if (eventName != null) {
            AnalyticLoggerUtil.logNotifyEvent(context, "show_$eventName")
            intent.putExtra("eventName", eventName)
        }
        val pendingIntent = PendingIntent.getActivity(
            applicationContext,
            System.currentTimeMillis().toInt(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        val killAppContent = NotificationUtil.remoteNotification?.killApp
        NotificationUtil.showNotification(
            applicationContext,
            notificationId = NotificationUtil.KILL_APP_NOTIFICATION_ID,
            title = killAppContent?.title
                ?: applicationContext.getString(R.string.unfinished_file_detected),
            message = killAppContent?.message
                ?: applicationContext.getString(R.string.an_unread_file_need_your_attention),
            pendingIntent = pendingIntent,
        )
        return Result.success()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createForegroundInfo(): ForegroundInfo {
        val channelId = "ForegroundChannel"
        val channelName = "Foreground Service"

        val notificationManager =
            applicationContext.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val channel =
            NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_LOW)
        notificationManager.createNotificationChannel(channel)

        val notification: Notification = NotificationCompat.Builder(applicationContext, channelId)
            .setContentTitle("All File Viewer")
            .setContentText("Service is running in the background")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .build()

        return ForegroundInfo(2, notification)
    }
}
