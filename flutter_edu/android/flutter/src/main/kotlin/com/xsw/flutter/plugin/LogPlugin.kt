package com.xsw.flutter.plugin

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * ClassName: [LogPlugin]
 * Description:
 *
 * Create by X at 2021/05/28 10:13.
 */
class LogPlugin(
        context: Context,
        flutterEngine: FlutterEngine
) : FlutterPlugin(context, flutterEngine) {

    override fun providerName() = "log"

    override fun onMethodInvoke(method: MethodCall, result: MethodChannel.Result) {
        (method.arguments as? Map<String, Any>)?.apply {
            val tag = "${get("tag") ?: TAG}"
            val message = "${get("message")}"
            when(method.method) {
                "v" -> {
                    Log.v(tag, message)
                }
                "d" -> {
                    Log.d(tag, message)
                }
                "i" -> {
                    Log.i(tag, message)
                }
                "w" -> {
                    Log.w(tag, message)
                }
                "e" -> {
                    Log.e(tag, message)
                    MessageManager.globalSend("message from native.")
                }
            }
            result.success(true)
        } ?: callError(result, "params format error!")
    }

}