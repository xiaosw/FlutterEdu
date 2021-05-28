package com.xsw.edu.flutter

import com.xsw.flutter.FlutterManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    var TAG = javaClass.simpleName

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FlutterManager.inject(flutterEngine)
    }

}
