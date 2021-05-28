package com.xsw.flutter

import android.app.Application
import kotlin.properties.Delegates

/**
 * ClassName: [AndroidContext]
 * Description:
 *
 * Create by X at 2021/05/28 09:57.
 */
object AndroidContext {

    var app by Delegates.notNull<Application>()
        private set

    fun init(app: Application) {
        this.app = app
    }

}