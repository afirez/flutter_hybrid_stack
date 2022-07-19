package com.common.flutter_hybrid_stack_example

import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.common.flutter_hybrid_stack.FlutterHostActivity

class NativeActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)

        var buttonOpenFlutter = findViewById<View>(R.id.buttonOpenFlutter)

        buttonOpenFlutter.setOnClickListener {
            var intent = Intent(this, FlutterHostActivity::class.java)
            intent.putExtra("route", "/details")
            startActivity(intent)
        }
    }
}