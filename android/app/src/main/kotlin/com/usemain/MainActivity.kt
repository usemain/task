package com.usemain

import android.os.Bundle
import android.view.WindowManager
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val channel = "usemain/backChannel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.isAppearanceLightNavigationBars = true

        window.setFlags(
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS
        )

        // extendDisplayTime()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "backDesktop") {
                moveTaskToBack(false)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

//    private fun extendDisplayTime() {
//        val viewModel = ViewModel(application)
//        val content = findViewById<View>(android.R.id.content)
//
//        content.viewTreeObserver.addOnPreDrawListener(object : ViewTreeObserver.OnPreDrawListener {
//            override fun onPreDraw(): Boolean {
//                return if (viewModel.isReady()) {
//                    content.viewTreeObserver.removeOnPreDrawListener(this)
//                    true
//                } else {
//                    false
//                }
//            }
//        })
//    }
//
//    class ViewModel(application: Application) : AndroidViewModel(application) {
//        private val startUptimeMillis: Long = SystemClock.uptimeMillis()
//
//        fun isReady(): Boolean {
//            return SystemClock.uptimeMillis() - startUptimeMillis > 1000
//        }
//    }
}
