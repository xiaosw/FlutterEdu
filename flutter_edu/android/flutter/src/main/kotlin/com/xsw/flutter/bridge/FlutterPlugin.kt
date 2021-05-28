package com.xsw.flutter.bridge

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

/**
 * ClassName: [FlutterPlugin]
 * Description:
 *
 * Create by X at 2021/05/28 10:14.
 */
abstract class FlutterPlugin(
        protected val context: Context,
        flutterEngine: FlutterEngine
) : MethodChannel.MethodCallHandler {

    val TAG = javaClass.simpleName

    val channelName
        get() = "${providerPackageName()}/${providerName()}"

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.e(TAG, "onMethodCall: ${call.method}(${call.arguments})")
        onMethodInvoke(call, result)
    }

    protected open fun providerPackageName() = PLUGIN_PACKAGE_NAME

    fun callError(result: MethodChannel.Result,
              errorMessage: String? = null,
              errorCode: String? = CODE_ERROR,
              errorDetails: Any? = null) {
        try {
            result.error(errorCode, errorMessage, errorDetails)
        } catch (e: Exception) {
            Log.e(TAG, "error: ", e)
        }
    }

    protected abstract fun providerName() : String

    abstract fun onMethodInvoke(method: MethodCall, result: MethodChannel.Result)

    companion object {
        const val PLUGIN_PACKAGE_NAME = "com.xsw.flutter"
        const val CODE_ERROR = "-1"
    }
}