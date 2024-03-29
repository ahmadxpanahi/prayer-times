package com.example.prayer_times_flutter

import io.flutter.embedding.android.FlutterActivity
import android.content.ContentResolver
import android.content.Context
import android.media.RingtoneManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "alpha.dev/flutter_local_notifications").setMethodCallHandler { call, result ->            
            if ("getAlarmUri" == call.method) {
                result.success(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM).toString())
            }
        }
    }
}
