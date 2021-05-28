package com.xsw.edu.flutter

import com.xsw.flutter.bridge.PluginManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        PluginManager.register(this, flutterEngine)
    }

}
