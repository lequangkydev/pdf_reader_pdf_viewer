package com.vtn.global.base.flutter.utils
import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.LocaleList
import java.util.Locale
import androidx.core.content.edit


object LocaleHelper {

    fun saveToPreferences(context: Context, key: String, value: String) {
        val sharedPreferences = context.getSharedPreferences("MyPrefs", Context.MODE_PRIVATE)
        sharedPreferences.edit() {
            putString(key, value)
            apply()
        }  // Hoặc dùng editor.commit() nếu muốn lưu ngay lập tức
    }

    fun setLocale(context: Context, language: String) {
        val locale = Locale(language)
        Locale.setDefault(locale)

        val resources = context.resources

        val configuration = resources.configuration
        configuration.locale = locale
        configuration.setLayoutDirection(locale)

        resources.updateConfiguration(configuration, resources.displayMetrics)
        saveToPreferences(context, "language", language)
    }
}
