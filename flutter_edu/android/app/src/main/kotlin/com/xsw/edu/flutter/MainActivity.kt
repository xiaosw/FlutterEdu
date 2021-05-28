package com.xsw.edu.flutter

import android.os.Handler
import android.util.Log
import com.xsw.flutter.bridge.MessageManager
import com.xsw.flutter.bridge.PluginManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    var TAG = javaClass.simpleName

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        PluginManager.init(this, flutterEngine)
    }

}
