package com.xsw.flutter.bridge

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/**
 * ClassName: [PluginManager]
 * Description:
 *
 * Create by X at 2021/05/28 10:33.
 */
object PluginManager {

    fun register(context: Context, flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        registerPlugin(messenger, LogPlugin(context, flutterEngine))
    }

    fun registerPlugin(messenger: BinaryMessenger, flutterPlugin: FlutterPlugin) {
        MethodChannel(messenger, flutterPlugin.channelName)
                .setMethodCallHandler(flutterPlugin)
    }

}