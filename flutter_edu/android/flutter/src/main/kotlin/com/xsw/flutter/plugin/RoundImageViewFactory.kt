package com.xsw.flutter.plugin

import android.content.Context
import com.xsw.flutter.widget.RoundImageView
import io.flutter.embedding.engine.FlutterEngine

/**
 * ClassName: [RoundImageViewFactory]
 * Description:
 *
 * Create by X at 2021/05/28 14:44.
 */
class RoundImageViewFactory(
        context: Context,
        flutterEngine: FlutterEngine
) : FlutterView<RoundImageView>(context, flutterEngine) {

    override fun onCreateView(context: Context, viewId: Int) = RoundImageView(context)

    override fun onApplyStyle(view: RoundImageView, style: Style) {
        with(view) {
            layoutParams.apply {
                width = style.width
                height = style.height
                layoutParams = this
            }
            forceCircle = style.forceCircle
            resizeClip = style.resizeClip
            setBackgroundColor(style.background)
            view.invalidate()
        }
    }

    override fun providerName() = "round_image_view"

}