package com.vtn.global.base.flutter

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.os.Environment
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatDelegate
import com.ahmadullahpk.alldocumentreader.R
import com.ahmadullahpk.alldocumentreader.xs.common.IOfficeToPicture
import com.ahmadullahpk.alldocumentreader.xs.constant.EventConstant
import com.ahmadullahpk.alldocumentreader.xs.constant.MainConstant
import com.ahmadullahpk.alldocumentreader.xs.macro.DialogListener
import com.ahmadullahpk.alldocumentreader.xs.res.ResKit
import com.ahmadullahpk.alldocumentreader.xs.ss.sheetbar.SheetBar
import com.ahmadullahpk.alldocumentreader.xs.system.IMainFrame
import com.ahmadullahpk.alldocumentreader.xs.system.MainControl
import com.vtn.global.base.flutter.utils.AppConstant
import com.vtn.global.base.flutter.utils.SharedPreferencesUtil
import io.flutter.plugin.platform.PlatformView
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.util.Locale


class ActivityViewFiles(
    private val activity: Activity,
    context: Context,
    id: Int,
    creationParams: Map<String?, Any?>?
) :
    PlatformView, IMainFrame {

    private val TAG = ActivityViewFiles::class.java.simpleName

    private val layout: LinearLayout = LinearLayout(context).apply {
        orientation = LinearLayout.VERTICAL
    }

    private var applicationType = -1

    private val bg: Any = -7829368

    private var control: MainControl? = MainControl(this)

    private var filePath: String? = creationParams?.get("pathFile") as? String

    private var isFromAppActivity: Boolean = true

    private var isDispose: Boolean = false

    private var tempFilePath: String? = null

    private var gapView: View? = null

    private val writeLog = true

    private var isThumbnail = false

    private var bottomBar: SheetBar? = null

    init {
        AppConstant.recentFilePath = filePath
        SharedPreferencesUtil(context).saveRecentFile(filePath!!)
        try {
            AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO)
        } catch (e: Exception) {
            e.printStackTrace()
        }
        this.control = MainControl(this)

        /*     this.filePath = creationParams?.get("filePath") as? String ?: "No file path provided"
             this.fileName = creationParams?.get("fileName") as? String ?: "No file name provided"
             this.isFromAppActivity = true*/
        createView()
        this.control!!.openFile(this.filePath)
        this.control!!.setOffictToPicture(object : IOfficeToPicture {
            private var bitmap: Bitmap? = null

            override fun dispose() {
            }

            override fun getModeType(): Byte {
                return 1
            }

            override fun isZoom(): Boolean {
                return false
            }

            override fun setModeType(b: Byte) {
            }

            override fun getBitmap(i: Int, i2: Int): Bitmap? {
                if (i == 0 || i2 == 0) {
                    return null
                }
                val bitmap = this.bitmap
                if (!(bitmap != null && bitmap.width == i && this.bitmap!!.height == i2)) {
                    val bitmap3 = this.bitmap
                    bitmap3?.recycle()
                    this.bitmap = Bitmap.createBitmap(i, i2, Bitmap.Config.ARGB_8888)
                }
                return this.bitmap!!
            }

            override fun callBack(bitmap: Bitmap) {
                saveBitmapToFile(bitmap)
            }
        })
    }


    private fun saveBitmapToFile(bitmap: Bitmap?) {
        if (bitmap == null) {
            return
        }
        if (this.tempFilePath == null) {
            if ("mounted" == Environment.getExternalStorageState()) {
                this.tempFilePath = Environment.getExternalStorageDirectory().absolutePath
            }
            val stringBuilder: String = this.tempFilePath +
                    File.separatorChar +
                    "tempPic"
            val file = File(stringBuilder)
            if (!file.exists()) {
                file.mkdir()
            }
            this.tempFilePath = file.absolutePath
        }
        val stringBuilder: String = this.tempFilePath +
                File.separatorChar +
                "export_image.jpg"
        val file = File(stringBuilder)
        try {
            if (file.exists()) {
                file.delete()
            }
            file.createNewFile()
            val fileOutputStream = FileOutputStream(file)
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fileOutputStream)
            fileOutputStream.flush()
            fileOutputStream.close()
        } catch (ex: IOException) {
            Log.e(TAG, "saveBitmapToFile: ", ex)
        }
    }


    fun getDialogListener(): DialogListener? {
        return null
    }

    override fun setFindBackForwardState(state: Boolean) {
    }


    override fun getTopBarHeight(): Int {
        return 0
    }


    override fun onEventMethod(
        v: View?,
        e1: MotionEvent?,
        e2: MotionEvent?,
        xValue: Float,
        yValue: Float,
        eventMethodType: Byte
    ): Boolean {
        return false
    }

    override fun isDrawPageNumber(): Boolean {
        return true
    }

    override fun isShowZoomingMsg(): Boolean {
        return true
    }

    override fun isPopUpErrorDlg(): Boolean {
        return true
    }

    override fun isShowPasswordDlg(): Boolean {
        return true
    }

    override fun isShowProgressBar(): Boolean {
        return true
    }

    override fun isShowFindDlg(): Boolean {
        return true
    }

    override fun isShowTXTEncodeDlg(): Boolean {
        return true
    }

    override fun getTXTDefaultEncode(): String {
        return "GBK"
    }

    override fun isTouchZoom(): Boolean {
        return true
    }

    override fun isZoomAfterLayoutForWord(): Boolean {
        return true
    }

    override fun getWordDefaultView(): Byte {
        return 0
    }

    override fun getLocalString(resName: String): String {
        return try {
            ResKit.instance()
                .getLocalString(resName)/* ?: "Default Value"  */// Giá trị mặc định nếu null
        } catch (e: Exception) {
            "Error retrieving resource"  // Thông báo lỗi
        }
    }


    override fun changeZoom() {
    }

    override fun changePage() {
    }

    override fun completeLayout() {
    }

    override fun error(errorCode: Int) {
    }

    override fun fullScreen(fullscreen: Boolean) {
    }

    override fun showProgressBar(visible: Boolean) {
    }

    override fun updateViewImages(viewList: List<Int?>?) {
    }

    override fun isChangePage(): Boolean {
        return true
    }

    override fun setWriteLog(saveLog: Boolean) {
        TODO("Not yet implemented")
    }


    override fun setIgnoreOriginalSize(ignoreOriginalSize: Boolean) {
    }

    override fun isIgnoreOriginalSize(): Boolean {
        return false
    }

    override fun getPageListViewMovingPosition(): Byte {
        return 0
    }

    private fun createView() {
        val lowerCase = filePath!!.lowercase(Locale.getDefault())
        if (lowerCase.endsWith(MainConstant.FILE_TYPE_DOC) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_DOCX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_TXT) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_DOT) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_DOTX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_DOTM)
        ) {
            this.applicationType = 0
        } else if (lowerCase.endsWith(MainConstant.FILE_TYPE_XLS) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_XLSX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_XLT) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_XLTX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_XLTM) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_XLSM)
        ) {
            this.applicationType = 1
        } else if (lowerCase.endsWith(MainConstant.FILE_TYPE_PPT) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_PPTX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_POT) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_PPTM) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_POTX) ||
            lowerCase.endsWith(MainConstant.FILE_TYPE_POTM)
        ) {
            this.applicationType = 2
        } else if (lowerCase.endsWith("pdf")) {
            this.applicationType = 3
        } else {
            this.applicationType = 0
        }
    }


    override fun updateToolsbarStatus() {
        if (!this.isDispose) {
            val childCount = this.layout.childCount
            for (i in 0 until childCount) {
                this.layout.getChildAt(i)
            }
        }
    }

    override fun getActivity(): Activity {
        return this.activity
    }

    override fun doActionEvent(i: Int, obj: Any): Boolean {
        if (i == 0) {
            onBackPressed()
        } else if (i != 15) {
            if (i == 20) {
                updateToolsbarStatus()
            } else if (i == 25) {
                activity.title = obj as String
            } else if (i != 268435464) {
                if (i == 536870913) {
                } else if (i == 788529152) {
                    val trim = (obj as String).trim { it <= ' ' }
                    if (trim.isEmpty() || !this.control!!.find.find(trim)) {
                        setFindBackForwardState(false)
                    } else {
                        setFindBackForwardState(true)
                    }
                } else if (i != 1073741828) {
                    when (i) {
                        EventConstant.APP_DRAW_ID -> {
                            this.control!!.getSysKit().getCalloutManager().setDrawingMode(1)
                            this.layout.post(Runnable {
                                this.control!!.actionEvent(
                                    EventConstant.APP_INIT_CALLOUTVIEW_ID,
                                    null
                                )
                            })
                        }

                        EventConstant.APP_BACK_ID -> this.control!!.getSysKit().getCalloutManager()
                            .setDrawingMode(0)

                        EventConstant.APP_PEN_ID -> if (!(obj as Boolean)) {
                            this.control!!.getSysKit().getCalloutManager().setDrawingMode(0)
                        } else {
                            this.control!!.getSysKit().getCalloutManager().setDrawingMode(1)
                            this.layout.post(Runnable {
                                this.control!!.actionEvent(
                                    EventConstant.APP_INIT_CALLOUTVIEW_ID,
                                    null
                                )
                            })
                        }

                        EventConstant.APP_ERASER_ID -> {
                            try {
                                if (!(obj as Boolean)) {
                                    this.control!!.getSysKit().getCalloutManager().setDrawingMode(0)
                                } else {
                                    this.control!!.getSysKit().getCalloutManager().setDrawingMode(2)
                                }
                            } catch (e: Exception) {
                                this.control!!.getSysKit().getErrorKit().writerLog(e)
                            }
                            return false
                        }

                        else -> return false
                    }
                } else {
                    this.bottomBar!!.setFocusSheetButton(obj as Int)
                }
            }
        }
        return true
    }

    override fun openFileFinish() {
        val view = View(this.activity)
        this.gapView = view
        view.setBackgroundColor(-7829368)
        // this.appFrame.addView(this.gapView, new LinearLayout.LayoutParams(-1, 1));
        this.layout.addView(this.control!!.getView(), LinearLayout.LayoutParams(-1, -1))
    }

    private fun onBackPressed() {
        var actionValue =
            control!!.getActionValue(EventConstant.PG_SLIDESHOW, null)
        if (actionValue == null || !(actionValue as Boolean)) {
            if (control!!.reader != null) {
                control!!.reader.abortReader()
            }
            val mainControl = this.control
            if (mainControl == null || !mainControl.isAutoTest) {
                if (this.isFromAppActivity) {
                    activity.finish()
                    // startActivity(new Intent(this, Main_Home_Activity.class));
                }

                activity.overridePendingTransition(R.anim.slide_from_left, R.anim.slide_to_right)
                return
            }
            System.exit(0)
            return
        }
        fullScreen(false)
        control!!.actionEvent(EventConstant.PG_SLIDESHOW_END, null)
    }


    override fun getBottomBarHeight(): Int {
        val sheetBar = this.bottomBar
        if (sheetBar != null) {
            return sheetBar.sheetbarHeight
        }
        return 0
    }

    override fun getAppName(): String {
        return "All Document Viewer"
    }

    override fun isWriteLog(): Boolean {
        return this.writeLog
    }

    override fun setThumbnail(z: Boolean) {
        this.isThumbnail = z
    }

    override fun getViewBackground(): Any {
        return this.bg
    }

    override fun isThumbnail(): Boolean {
        return this.isThumbnail
    }

    override fun getTemporaryDirectory(): File {
        val externalFilesDir: File? = this.activity.getExternalFilesDir(null)
        if (externalFilesDir != null) {
            return externalFilesDir
        }
        return this.activity.filesDir
    }

    override fun getView(): View {
        return this.layout
    }

    override fun dispose() {
        this.isDispose = true

        val mainControl: MainControl = this.control!!
        mainControl.dispose()
        this.control = null
        this.bottomBar = null
        val linearLayout: LinearLayout = this.layout
        val childCount = linearLayout.childCount
        for (i in 0 until childCount) {
            this.layout.getChildAt(i)
        }
    }
}