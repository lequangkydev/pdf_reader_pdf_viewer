package com.vtn.global.base.flutter.utils.worker

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Environment
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.work.ForegroundInfo
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.vtn.global.base.flutter.R
import com.vtn.global.base.flutter.utils.AnalyticLoggerUtil
import com.vtn.global.base.flutter.utils.RecursiveFileObserver


class FileObserverWorker(context: Context, workerParams: WorkerParameters) :
    Worker(context, workerParams) {

    private var downloadObserver: RecursiveFileObserver? = null
    private var pictureObserver: RecursiveFileObserver? = null
    private var screenShortObserver: RecursiveFileObserver? = null
    private var cameraObserver: RecursiveFileObserver? = null

    @RequiresApi(Build.VERSION_CODES.O)
    override fun doWork(): Result {
        createForegroundInfo()
        // Thực hiện công việc của Worker
        println("🔹 Worker đang chạy...")
        startFileObserver()
        // Keep worker running (blocking operation)
        try {
            while (!isStopped) {
                Thread.sleep(5000) // Prevent CPU overload
            }
        } catch (e: InterruptedException) {
            Log.e("TAG", "Worker interrupted", e)
        } finally {
            stopFileObserver()
        }
        return Result.success()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createForegroundInfo(): ForegroundInfo {
        val channelId = "FileObserverChannel"
        val channelName = "File Observer Service"

        val notificationManager =
            applicationContext.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val channel =
            NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_LOW)
        notificationManager.createNotificationChannel(channel)

        val notification: Notification = NotificationCompat.Builder(applicationContext, channelId)
            .setContentTitle("Monitoring Files")
            .setContentText("FileObserver is running in the background")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .build()

        return ForegroundInfo(1, notification)
    }

    private fun startFileObserver() {
        val downloadPath =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).absolutePath
        val picturePath =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).absolutePath
        val screenShortPath =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).absolutePath + "/Screenshots"
        val cameraPath =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).absolutePath + "/Camera"
        downloadObserver = RecursiveFileObserver(
            downloadPath,
            applicationContext,
            eventName = AnalyticLoggerUtil.NOTI_NEW_DOWNLOAD_FILE
        )
        pictureObserver = RecursiveFileObserver(
            picturePath,
            applicationContext,
            eventName = AnalyticLoggerUtil.NOTI_NEW_DOWNLOAD_FILE
        )
        screenShortObserver = RecursiveFileObserver(
            screenShortPath,
            applicationContext,
            eventName = AnalyticLoggerUtil.NOTI_SCREEN_SHOT
        )
        cameraObserver = RecursiveFileObserver(
            cameraPath, applicationContext,
            eventName = AnalyticLoggerUtil.NOTI_SCREEN_SHOT
        )
        downloadObserver?.startWatching()
        pictureObserver?.startWatching()
        screenShortObserver?.startWatching()
        cameraObserver?.startWatching()
    }


    private fun stopFileObserver() {
        downloadObserver?.stopWatching()
        pictureObserver?.stopWatching()
        screenShortObserver?.stopWatching()
        cameraObserver?.stopWatching()
    }

    override fun onStopped() {
        super.onStopped()
        stopFileObserver()
    }

}

