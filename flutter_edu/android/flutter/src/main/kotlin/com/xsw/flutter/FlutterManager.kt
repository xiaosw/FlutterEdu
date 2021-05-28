package com.xsw.flutter

import android.app.Application
import com.xsw.flutter.plugin.MessageManager
import com.xsw.flutter.plugin.PluginManager
import io.flutter.embedding.engine.FlutterEngine
import kotlin.properties.Delegates

/**
 * ClassName: [FlutterManager]
 * Description:
 *
 * Create by X at 2021/05/28 14:33.
 */
object FlutterManager {
    var app by Delegates.notNull<Application>()
        private set

    fun init(app: Application) {
        this.app = app
    }

    fun inject(flutterEngine: FlutterEngine) {
        PluginManager.init(app, flutterEngine)
        MessageManager.init(flutterEngine)
    }
}