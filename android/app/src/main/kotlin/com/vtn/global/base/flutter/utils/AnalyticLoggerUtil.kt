package com.vtn.global.base.flutter.utils

import android.content.Context
import android.os.Bundle
import com.google.firebase.FirebaseApp
import com.google.firebase.analytics.FirebaseAnalytics
import com.vtn.global.base.flutter.BuildConfig

object AnalyticLoggerUtil {
    const val NOTI_FLASH_RECENTLY = "noti_flash_recently"
    const val NOTI_NEW_DOWNLOAD_FILE = "noti_new_download_file"
    const val NOTI_SCREEN_SHOT = "noti_screen_shot"
    const val NOTI_AFTER_30M = "noti_after_30m"
    const val NOTI_PERIODIC_5M = "noti_periodic_5m"

    fun logEvent(
        context: Context,
        eventName: String,
        params: Map<String, String>? = null
    ) {

        FirebaseApp.initializeApp(context)
        val firebaseAnalytics = FirebaseAnalytics.getInstance(context)
        val bundle = Bundle()
        if (params != null) {
            for ((key, value) in params) {
                bundle.putString(key, value)
            }
        }
        firebaseAnalytics.logEvent(eventName, bundle)
    }

    fun logNotifyEvent(
        context: Context,
        eventName: String,
        params: Map<String, String>? = null
    ) {
        logEvent(context, eventName + "_version" + BuildConfig.VERSION_CODE, params)
    }
}