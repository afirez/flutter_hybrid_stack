package com.common.flutter_hybrid_stack_example

import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.blankj.utilcode.util.ToastUtils
import com.blankj.utilcode.util.Utils
import com.common.flutter_hybrid_stack.FlutterHostActivity
import com.common.flutter_hybrid_stack.FlutterHostHelper

class MainActivity : AppCompatActivity() {

    private var loadingDialog: AlertDialog? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)
        Utils.init(application)
        var buttonInitFlutter = findViewById<View>(R.id.buttonInitFlutter)
        var startFlutter = findViewById<View>(R.id.startFlutter)
        var releaseFlutter = findViewById<View>(R.id.releaseFlutter)

        FlutterHostHelper.instance.openNativeRoute = { route:String?, params: HashMap<String, Any>? ->
            //这里本来是要根据路由打开activity的，我就随便演示一下啦
            val intent = Intent(this, NativeActivity::class.java)
            startActivity(intent)
        }

        buttonInitFlutter.setOnClickListener {


            FlutterHostHelper.instance.initFlutterEngine(this) {
                when (it) {
                    0 -> {
                        ToastUtils.showShort("FlutterEngine已经初始化完毕了！")
                    }
                    1 -> {
                        showLoading()
                    }
                    2 -> {
                        hiddenLoading()
                        ToastUtils.showShort("初始化完毕！")
                    }
                }
            }
        }

        startFlutter.setOnClickListener {
            if (FlutterHostHelper.instance.isInitFinish()) {
                var intent = Intent(this, FlutterHostActivity::class.java)
                intent.putExtra("route", "/home")
                startActivity(intent)
            } else {
                ToastUtils.showShort("请先初始化FlutterEngine")
            }
        }

        releaseFlutter.setOnClickListener {
            FlutterHostHelper.instance.release()
        }
    }

    private inline fun showLoading() {
        if (loadingDialog == null) {
            loadingDialog = AlertDialog.Builder(this).setMessage("FlutterEngine正在初始化，请稍候~").show()
        } else {
            loadingDialog?.show()
        }
    }

    private inline fun hiddenLoading() {
        loadingDialog?.dismiss()
    }

}
