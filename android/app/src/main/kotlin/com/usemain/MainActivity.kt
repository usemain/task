package com.usemain

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode

class MainActivity : FlutterFragmentActivity() {
    private val channel = "usemain/backChannel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "backDesktop") {
                moveTaskToBack(false)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun getBackgroundMode(): BackgroundMode {
        return BackgroundMode.transparent
    }
}
