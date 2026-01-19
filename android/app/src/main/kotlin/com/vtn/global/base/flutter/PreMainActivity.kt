package com.vtn.global.base.flutter

import android.app.Activity
import android.content.Intent
import android.os.Bundle


class PreMainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Nếu intent này do chính app mình gửi ra và quay lại → bỏ qua
        if (intent.getBooleanExtra("internal_launch", false)) {
            finish()
            return
        }
        val mainActivityClass = Class.forName("com.vtn.global.base.flutter.MainActivity")
        val forwardIntent = Intent(this, mainActivityClass).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
            setDataAndType(intent.data, intent.type)
            action = intent.action
        }
        startActivity(forwardIntent)
        finish()

    }
}