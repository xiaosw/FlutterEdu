package com.xsw.flutter.plugin

import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec

/**
 * ClassName: [MessageManager]
 * Description:
 *
 * Create by X at 2021/05/28 11:51.
 */
object MessageManager {

    private var TAG = javaClass.simpleName

    private const val CHANNEL_NAME_GLOBAL_MESSAGE = "com.xsw.flutter.message/global"
    private var mMessageChannel: BasicMessageChannel<String>? = null

    internal fun init(flutterEngine: FlutterEngine) {
        mMessageChannel = BasicMessageChannel<String>(flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL_NAME_GLOBAL_MESSAGE,
                StringCodec.INSTANCE).also {
            it.setMessageHandler { message, reply ->
                Log.e(TAG, "receiver message -----------> $message")
            }
        }
    }

    fun globalSend(message: String, repay: BasicMessageChannel.Reply<String>? = null) {
        mMessageChannel?.send(message) {
            repay?.reply(it)
        }
    }

}