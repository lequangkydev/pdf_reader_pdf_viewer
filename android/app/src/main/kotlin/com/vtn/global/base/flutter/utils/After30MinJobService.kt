package com.vtn.global.base.flutter.utils

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.app.job.JobParameters
import android.app.job.JobService
import android.content.Intent
import com.vtn.global.base.flutter.MainActivity
import com.vtn.global.base.flutter.R

@SuppressLint("SpecifyJobSchedulerIdRange")
class After30MinJobService : JobService() {

    companion object {
        const val JOB_ID = 1001
    }

    @SuppressLint("MissingPermission")
    override fun onStartJob(params: JobParameters): Boolean {
        val eventName = AnalyticLoggerUtil.NOTI_AFTER_30M
        val intent = Intent(applicationContext, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
        intent.putExtra("filePath", AppConstant.recentFilePath)
        intent.putExtra("eventName", eventName)

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
            eventName = eventName
        )
        return false
    }

    override fun onStopJob(params: JobParameters): Boolean {
        return false
    }
}
