package com.vtn.global.base.flutter

import android.Manifest
import android.app.job.JobInfo
import android.app.job.JobScheduler
import android.content.ComponentName
import android.content.Context
import androidx.annotation.RequiresPermission
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ProcessLifecycleOwner
import androidx.work.WorkManager
import com.vtn.global.base.flutter.utils.After30MinJobService
import com.vtn.global.base.flutter.utils.AnalyticLoggerUtil
import com.vtn.global.base.flutter.utils.NotificationUtil
import com.vtn.global.base.flutter.utils.worker.RecentFileWorker
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime


class MainApplication : FlutterApplication() {
    lateinit var appLifecycleObserver: AppLifecycleObserver
    override fun onCreate() {
        super.onCreate()
        appLifecycleObserver = AppLifecycleObserver(applicationContext)
        ProcessLifecycleOwner.get().lifecycle.addObserver(appLifecycleObserver)
    }

    fun getMethodChannel(): MethodChannel? {
        return appLifecycleObserver.methodChannel
    }
}

class AppLifecycleObserver(private val context: Context) : DefaultLifecycleObserver {
    var methodChannel: MethodChannel? = null
    var hideAppTime: LocalDateTime? = null

    private fun isJobScheduled(context: Context, jobId: Int): Boolean {
        val scheduler = context.getSystemService(Context.JOB_SCHEDULER_SERVICE) as JobScheduler?
        if (scheduler != null) {
            val allJobs = scheduler.allPendingJobs
            for (jobInfo in allJobs) {
                if (jobInfo.id == jobId) {
                    return true
                }
            }
        }
        return false
    }

    private fun startAfter30MinJobService() {
        val scheduler =
            context.getSystemService(Context.JOB_SCHEDULER_SERVICE) as JobScheduler
        if (isJobScheduled(context, After30MinJobService.JOB_ID)) {
            scheduler.cancel(After30MinJobService.JOB_ID)
        }
        val componentName = ComponentName(
            context,
            After30MinJobService::class.java
        )
        val jobInfo = JobInfo.Builder(After30MinJobService.JOB_ID, componentName)
            .setMinimumLatency((30 * 60 * 1000).toLong())
            .build()
        scheduler.schedule(jobInfo)
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)
        hideAppTime = LocalDateTime.now()
        NotificationUtil.showRecentFileNotification(
            context,
            eventName = AnalyticLoggerUtil.NOTI_FLASH_RECENTLY,
        )

        RecentFileWorker.schedulePeriodicWork(
            context,
            eventName = AnalyticLoggerUtil.NOTI_FLASH_RECENTLY,
        )
        startAfter30MinJobService()
    }

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)
        if (hideAppTime == null) return
        WorkManager.getInstance(context)
            .cancelUniqueWork("MyPeriodicWorker")
        val scheduler =
            context.getSystemService(Context.JOB_SCHEDULER_SERVICE) as JobScheduler
        if (isJobScheduled(context, After30MinJobService.JOB_ID)) {
            scheduler.cancel(After30MinJobService.JOB_ID)
        }

    }
}