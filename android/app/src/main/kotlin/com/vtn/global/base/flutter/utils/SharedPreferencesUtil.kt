package com.vtn.global.base.flutter.utils

import android.content.Context
import android.content.SharedPreferences
import androidx.core.content.edit

class SharedPreferencesUtil(context: Context) {
    private val prefs: SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    companion object {
        private const val PREFS_NAME = "MyAppPrefs"
        private const val KEY_RECENT_FILE = "recentFile"
    }


    fun saveRecentFile(filePath: String) {
        prefs.edit {
            putString(KEY_RECENT_FILE, filePath)
        }
    }

    fun getRecentFile(): String? {
        return prefs.getString(KEY_RECENT_FILE, null)
    }
}