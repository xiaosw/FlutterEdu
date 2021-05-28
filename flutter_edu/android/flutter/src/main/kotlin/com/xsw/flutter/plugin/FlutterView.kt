package com.xsw.flutter.plugin

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.RelativeLayout
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.json.JSONObject
import java.lang.Exception
import kotlin.properties.Delegates

/**
 * ClassName: [FlutterView]
 * Description:
 *
 * Create by X at 2021/05/28 15:04.
 */
abstract class FlutterView<V : View>(
        private val context: Context,
        private val flutterEngine: FlutterEngine,
        createArgsCodec: MessageCodec<Any> = StandardMessageCodec()
) : PlatformView, PlatformViewFactory(createArgsCodec), PluginNameProvider {

    val TAG = javaClass.simpleName

    private var mView: V? = null
    private var mStyle by Delegates.notNull<Style>()
    private val mPlugin = object : FlutterPlugin(context, flutterEngine) {
        override fun onMethodInvoke(method: MethodCall, result: MethodChannel.Result) {
            this@FlutterView.onMethodInvoke(method, result)
        }

        override fun providerName() = this@FlutterView.providerName()

    }

    final override fun getView() = mView!!

    override fun dispose() {

    }

    override fun providerPackageName() = mPlugin.providerPackageName()

    final override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        if (null == mView) {
            mView = onCreateView(context ?: this.context, viewId).also {
                if (it.layoutParams == null) {
                    it.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                            RelativeLayout.LayoutParams.WRAP_CONTENT)
                }
            }
            PluginManager.registerPlugin(flutterEngine.dartExecutor.binaryMessenger, mPlugin)
        } else {
            (mView?.parent as? ViewGroup)?.removeView(mView)
        }
        mStyle = Style(this.context, args)
        Log.e(TAG, "create: context = $context, viewId = $viewId, args = $args， mStyle = $mStyle")
        onApplyStyle(mView!!, mStyle)

        return this
    }

    protected fun onMethodInvoke(method: MethodCall, result: MethodChannel.Result) {

    }


    protected abstract fun onCreateView(context: Context, viewId: Int) : V

    protected abstract fun onApplyStyle(view: V, style: Style)

    class Style(private val context: Context, args: Any?) {
        private var mMap: Map<String, Any?>? = null
        private var mJson: JSONObject? = null

        var width = ViewGroup.LayoutParams.WRAP_CONTENT
            private set
        var height = ViewGroup.LayoutParams.WRAP_CONTENT
            private set
        var resizeClip = false
            private set
        var forceCircle = false
            private set
        var background = Color.TRANSPARENT
            private set

        init {
            mJson = null
            mMap = null
            args?.apply {
                if (this is Map<*, *>) {
                    mMap = (this as Map<String, Any?>).also { attrs ->
                        sAttrs.forEach {
                            setupAttrs(it, attrs[it])
                        }
                    }
                } else if (this is String && this.trim().startsWith("{")) {
                    try {
                        mJson = JSONObject(this).also { jo ->
                            sAttrs.forEach {
                                setupAttrs(it, jo.opt(it))
                            }
                        }
                    } catch (e: Exception) {}
                }
            }
        }

        fun hasAttrs(attr: String) : Boolean {
            if (!mMap.isNullOrEmpty()) {
                return mMap!!.contains(attr)
            }
            mJson?.let {
                return it.has(attr)
            }
            return false
        }

        private inline fun toPx(dp: Float) = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,
                dp, context.resources.displayMetrics)

        private inline fun setupAttrs(attr: String, value: Any?) {
            value?.apply {
                when(attr) {
                    ATTR_WIDTH -> {
                        (this as? Number)?.let {
                            width = if (it.toInt() <= 0) {
                                it.toInt()
                            } else {
                                toPx(it.toFloat()).toInt()
                            }
                        }
                    }

                    ATTR_HEIGHT -> {
                        (this as? Number)?.let {
                            height = if (it.toInt() <= 0) {
                                it.toInt()
                            } else {
                                toPx(it.toFloat()).toInt()
                            }
                        }
                    }

                    ATTR_RESIZE_CLIP -> {
                        (this as? Boolean)?.let {
                            resizeClip = it
                        }
                    }

                    ATTR_FORCE_CIRCLE -> {
                        (this as? Boolean)?.let {
                            forceCircle = it
                        }
                    }

                    ATTR_BACKGROUND -> {
                        (this as? String)?.let {
                            background = android.graphics.Color.parseColor(it)
                        }
                    }

                }
            }
        }

        override fun toString(): String {
            return "{width = $width" +
                    ", height = $height, " +
                    ", resizeClip = $resizeClip" +
                    ", forceCircle = $forceCircle" +
                    ", background = $background}"
        }

        companion object {
            const val ATTR_WIDTH = "width"
            const val ATTR_HEIGHT = "height"
            const val ATTR_RESIZE_CLIP = "resizeClip"
            const val ATTR_FORCE_CIRCLE = "forceCircle"
            const val ATTR_BACKGROUND = "background"
            val sAttrs = mutableListOf<String>().also {
                it.add(ATTR_WIDTH)
                it.add(ATTR_HEIGHT)
                it.add(ATTR_RESIZE_CLIP)
                it.add(ATTR_FORCE_CIRCLE)
                it.add(ATTR_BACKGROUND)
            }
        }
    }

}
