package com.vtn.global.base.flutter


import android.Manifest
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import androidx.annotation.RequiresPermission
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.FileProvider
import androidx.core.net.toUri
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.lifecycle.lifecycleScope
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import com.google.firebase.FirebaseApp
import com.vtn.global.base.flutter.enum.ButtonPosition
import com.vtn.global.base.flutter.model.NotificationModel
import com.vtn.global.base.flutter.utils.AnalyticLoggerUtil
import com.vtn.global.base.flutter.utils.AppConstant
import com.vtn.global.base.flutter.utils.LocaleHelper
import com.vtn.global.base.flutter.utils.NotificationUtil
import com.vtn.global.base.flutter.utils.SharedPreferencesUtil
import com.vtn.global.base.flutter.utils.worker.FileObserverWorker
import com.vtn.global.base.flutter.utils.worker.KillAppNotificationWorker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Runnable
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.io.File
import java.util.Locale
import java.util.concurrent.TimeUnit
import com.adjust.helper.AdjustChannel


class MainActivity : FlutterActivity() {
    private val defaultAppCheckerChannel = "default_app_checker"

    private var pendingResult: MethodChannel.Result? = null
    private var waitingForReturnFromExternalIntent = false

    private val handler = Handler(Looper.getMainLooper())
    private var checkPermissionRunnable: Runnable? = null
    private var methodChannel: MethodChannel? = null
    private lateinit var sharedPreferences: SharedPreferencesUtil
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedPreferences = SharedPreferencesUtil(this)
        (application as MainApplication).appLifecycleObserver.methodChannel = methodChannel
        // Nhận dữ liệu từ Intent
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)

        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

        // lắng nghe action từ thông báo khi mở app
        val notificationAction = intent.getStringExtra("notification_action")
        if (notificationAction != null) {
            methodChannel?.invokeMethod(notificationAction, null)
        }
        // log event bấm vào thông báo
        val eventName = intent.getStringExtra("eventName")
        if (eventName != null) {
            AnalyticLoggerUtil.logNotifyEvent(context, "open_$eventName")
        }
        // Tạo worker lắng nghe thay đổi file và hiện thông báo
        val workRequest = OneTimeWorkRequestBuilder<FileObserverWorker>().build()
        WorkManager.getInstance(context).enqueue(workRequest)
    }

    var disableBack = false;
    override fun onBackPressed() {
        if (disableBack) {
            return;
        }
        super.onBackPressed();
    }

    // lên lịch thông báo hiển thị sau delayInDays ngày
    private fun scheduleWorker(delayInDays: Long) {
        KillAppNotificationWorker.scheduleUniqueWork(
            context,
            uniqueWorkName = "kill_app_$delayInDays",
            eventName = "kill_app_$delayInDays",
            delayInDays,
            TimeUnit.DAYS
        )
    }

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    override fun onDestroy() {
        scheduleWorker(1)
        scheduleWorker(3)
        scheduleWorker(7)
        scheduleWorker(15)
        scheduleWorker(30)
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        if (intent.getBooleanExtra("internal_launch", false)) {
            return
        }
        super.onNewIntent(intent)
        FirebaseApp.initializeApp(context)

        val filePath = intent.getStringExtra("filePath")
        val notificationAction = intent.getStringExtra("notification_action")
        // log event bấm vào thông báo
        val eventName = intent.getStringExtra("eventName")
        if (eventName != null) {
            AnalyticLoggerUtil.logNotifyEvent(context, "open_$eventName")
            methodChannel?.invokeMethod(
                "openNotify", null
            )
        }
        if (filePath != null) {
            // mở file từ thông báo
            val args = mapOf(
                "filePath" to filePath,
                "isSplash" to false
            )
            methodChannel?.invokeMethod("openFileFromNotification", args)
        } else if (notificationAction != null) {
            // chọn chức năng từ thông báo
            methodChannel?.invokeMethod(notificationAction, null)
        }
    }

    public override fun onResume() {
        super.onResume()
        if (waitingForReturnFromExternalIntent && pendingResult != null) {
            pendingResult?.success(null)
            pendingResult = null
            waitingForReturnFromExternalIntent = false
        }
    }

    public override fun onPause() {
        super.onPause()
    }


    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, defaultAppCheckerChannel
        )

        AdjustChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        val data = intent.getStringExtra("filePath")
        if (data != null) {
            val args = mapOf(
                "filePath" to data,
                "isSplash" to true
            )
            methodChannel?.invokeMethod("openFileFromNotification", args)
        }
        methodChannel!!.setMethodCallHandler { call, result ->
            when (call.method) {
                "initFullAds" -> {
                    AppConstant.isFullAds = call.argument<Boolean>("isFullAds") ?: false
                }

                "disableBack" -> {
                    disableBack = true;
                }

                "enableBack" -> {
                    disableBack = false;
                }

                "blockNotify" -> {
                    AppConstant.blockRecentFileNotification = true
                }

                "unBlockNotify" -> {
                    AppConstant.blockRecentFileNotification = false
                }

                "viewFile" -> {
                    val isViewFile = call.argument<Boolean>("isViewFile")
                    if (isViewFile != null) {
                        AppConstant.viewFile = isViewFile
                    }
                }

                "checkDefaultApp" -> {
                    val filePath = call.argument<String>("filePath")
                    if (filePath != null) {
                        val isDefault = checkDefaultApps(filePath)
                        result.success(isDefault)
                    } else {
                        result.error("INVALID_ARGUMENT", "File path is missing", null)
                    }

                }

                "openDefaultAppSettings" -> {
                    AppConstant.blockRecentFileNotification = true
                    val filePath = call.argument<String>("filePath")
                    if (filePath != null) {
                        openDefaultSettingMineType(result, filePath)
                        //openDefaultPdfSettings(result, filePath) // Truyền filePath vào hà
                        lifecycleScope.launch(Dispatchers.Main) {
                            delay(2000) // 1 giây
                            AppConstant.blockRecentFileNotification = false
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "File path is missing", null)
                    }
                }

                "openNotificationSettings" -> {
                    openNotificationSettings { isGranted ->
                        result.success(isGranted)
                    }
                }

                "openManageExternalStorage" -> {
                    AppConstant.blockRecentFileNotification = true
                    val pm: PackageManager = packageManager
                    val cm = ComponentName(this, FakeActivity::class.java)
                    pm.setComponentEnabledSetting(
                        cm,
                        PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                        PackageManager.DONT_KILL_APP
                    )
                    openManageExternalStorageSettings { isGranted ->
                        result.success(isGranted)
                    }
                    lifecycleScope.launch(Dispatchers.Main) {
                        delay(1000) // 1 giây
                        AppConstant.blockRecentFileNotification = false
                    }
                }

                "setRecentFilePath" -> {
                    val filePath = call.argument<String>("filePath")
                    AppConstant.recentFilePath = filePath
                    if (filePath != null) {
                        sharedPreferences.saveRecentFile(filePath)
                    }
                    result.success(null)
                }

                "showFunctionNotification" -> {
                    NotificationUtil.showFunctionNotification(applicationContext)
                    result.success(null)
                }

                "updateLocale" -> {
                    var languageCode = call.argument<String>("languageCode")
                    if (languageCode != null) {
                        if (languageCode == "id") {
                            languageCode = "in"
                        }
                        LocaleHelper.setLocale(context, languageCode)
                        LocaleHelper.setLocale(applicationContext, languageCode)
                        if (ActivityCompat.checkSelfPermission(
                                this, Manifest.permission.POST_NOTIFICATIONS
                            ) == PackageManager.PERMISSION_GRANTED
                        ) {
                            NotificationUtil.showFunctionNotification(this)
                        }
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }

                "setNotificationContent" -> {
                    val dataNotify = call.arguments as? HashMap<*, *>
                    if (dataNotify != null) {
                        NotificationUtil.remoteNotification = NotificationModel.fromJson(dataNotify)
                    }
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }

        flutterEngine.platformViewsController.registry.registerViewFactory(
            "openFile", NativeViewFactory(this.activity)
        )

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "topExtraNativeAd",
            ExtraNativeAd(context, buttonPosition = ButtonPosition.Top)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "topExtraNativeAdCustomColor",
            ExtraNativeAd(context, buttonPosition = ButtonPosition.Top, true)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "bottomExtraNativeAd",
            ExtraNativeAd(context, buttonPosition = ButtonPosition.Bottom)
        )

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "topNormalNativeAd",
            NormalNativeAd(context, buttonPosition = ButtonPosition.Top)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "bottomNormalNativeAd",
            NormalNativeAd(context, buttonPosition = ButtonPosition.Bottom)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "bottomNormalNativeAdCustomColor",
            NormalNativeAd(context, buttonPosition = ButtonPosition.Bottom, true)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "homeNativeAd", HomeNativeAd(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "smallNativeAd", SmallNativeAd(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "smallNativeAdCustomColor", SmallNativeAd(context, true)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "fullNativeAd", FullScreenNative(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "smallRightNativeAd", SmallRightNativeAd(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "smallRightNativeAdCustomColor", SmallRightNativeAd(context, true)
        )
    }

    private fun checkDefaultApps(filePath: String): Boolean {
        val file = File(filePath)
        if (!file.exists()) {
            return false;
        }
        val intent = Intent(Intent.ACTION_VIEW)
        val mimeType = when (file.extension.lowercase()) {
            "pdf" -> "application/pdf"
            "ppt" -> "application/vnd.ms-powerpoint"
            "pptx" -> "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            "doc" -> "application/msword"
            "docx" -> "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            "xls" -> "application/vnd.ms-excel"
            "xlsx" -> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            else -> "application/octet-stream" // Default MIME type
        }
        // Tạo URI giống hệt khi mở file thực tế
        val uri = FileProvider.getUriForFile(
            this,
            "${packageName}.provider",
            file
        )
        intent.setDataAndType(uri, mimeType)
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)

        val packageManager = this.packageManager
        val resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)

        return resolveInfo?.activityInfo?.packageName == packageName
    }

    private fun openDefaultSettingMineType(result: MethodChannel.Result, filePath: String) {
        val pm: PackageManager = packageManager
        val cm = ComponentName(this, FakeActivity::class.java)
        pm.setComponentEnabledSetting(
            cm, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP
        )
        Handler(Looper.getMainLooper()).postDelayed({
            openDefaultSettingMineType2(result, filePath)

            // Tắt FakeActivity sau khi mở intent
            pm.setComponentEnabledSetting(
                cm, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP
            )
        }, 350)
    }

    private fun openDefaultSettingMineType2(result: MethodChannel.Result, filePath: String) {
        try {
            val file = File(filePath)
            if (!file.exists()) {
                result.error("FILE_NOT_FOUND", "File does not exist", null)
                return
            }
            val uriForFile =
                FileProvider.getUriForFile(context, "${context.packageName}.provider", file)

            val mimeType = when (file.extension.lowercase()) {
                "pdf" -> "application/pdf"
                "ppt" -> "application/vnd.ms-powerpoint"
                "pptx" -> "application/vnd.openxmlformats-officedocument.presentationml.presentation"
                "doc" -> "application/msword"
                "docx" -> "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                "xls" -> "application/vnd.ms-excel"
                "xlsx" -> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                else -> "application/octet-stream" // Default MIME type
            }

            val intent = Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(uriForFile, mimeType)
                addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                putExtra("internal_launch", true)
                addCategory(Intent.CATEGORY_DEFAULT)
            }
            try {
                pendingResult = result
                waitingForReturnFromExternalIntent = true
                startActivity(intent)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun openManageExternalStorageSettings(callback: (Boolean) -> Unit) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION).apply {
                data = "package:${packageName}".toUri()
            }
            startActivity(intent)

            checkPermissionRunnable = object : Runnable {
                override fun run() {
                    if (Environment.isExternalStorageManager()) {
                        callback(true)
                        handler.removeCallbacks(this)
                        checkPermissionRunnable = null
                        val intent1 = Intent(this@MainActivity, MainActivity::class.java)
                        intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
                        startActivity(intent1)
                        return
                    } else {
                        handler.postDelayed(this, 500)
                    }
                }
            }
            handler.post(checkPermissionRunnable!!)
        } else {
            callback(false)
        }
    }

    private fun openNotificationSettings(callback: (Boolean?) -> Unit) {
        val checkNotificationPermissionRunnable: Runnable = object : Runnable {
            override fun run() {
                val notificationManagerCompat = NotificationManagerCompat.from(this@MainActivity)
                val isNotificationEnabled = notificationManagerCompat.areNotificationsEnabled()
                if (isNotificationEnabled) {
                    callback(true)
                    handler.removeCallbacks(this)
                    checkPermissionRunnable = null
                    val intent1 = Intent(this@MainActivity, MainActivity::class.java)
                    intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
                    startActivity(intent1)
                } else {
                    handler.postDelayed(this, 500)
                }
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intent = Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
            startActivity(intent)

            // Bắt đầu kiểm tra quyền thông báo
            handler.postDelayed(checkNotificationPermissionRunnable, 50)
        } else {
            openAppSettings()
            callback(null)
        }

    }

    private fun openAppSettings() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)

        activity.let {
            intent.data = Uri.fromParts("package", it.packageName, null)
            it.startActivity(intent)
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "topExtraNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "bottomExtraNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "topNormalNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "bottomNormalNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "homeNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "smallNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "smallRightNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "fullNativeAd")
    }


}
