package com.xsw.flutter.plugin

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformViewRegistry

/**
 * ClassName: [PluginManager]
 * Description:
 *
 * Create by X at 2021/05/28 10:33.
 */
object PluginManager {

    private val TAG = javaClass.simpleName

    fun init(context: Context, flutterEngine: FlutterEngine) {
        // utils
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        registerPlugin(messenger, LogPlugin(context, flutterEngine))

        // view
        val registry = flutterEngine.platformViewsController.registry
        registerViewFactory(registry, RoundImageViewFactory(context, flutterEngine))
    }

    fun registerPlugin(messenger: BinaryMessenger, flutterPlugin: FlutterPlugin) {
        Log.e(TAG, "registerPlugin: ${flutterPlugin.name} ---> ${flutterPlugin.javaClass.name}")
        MethodChannel(messenger, flutterPlugin.name)
                .setMethodCallHandler(flutterPlugin)
    }

    fun <F : FlutterView<*>> registerViewFactory(registry: PlatformViewRegistry, factory: F) {
        Log.e(TAG, "registerViewFactory: ${factory.name} ---> ${factory.javaClass.canonicalName}")
        registry.registerViewFactory(factory.name, factory)
    }

}