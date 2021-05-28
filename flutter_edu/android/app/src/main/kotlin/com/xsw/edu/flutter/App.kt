package com.xsw.edu.flutter

import android.app.Application
import com.xsw.flutter.AndroidContext

/**
 * ClassName: [App]
 * Description:
 *
 * Create by X at 2021/05/28 10:45.
 */
class App : Application() {

    override fun onCreate() {
        super.onCreate()
        AndroidContext.init(this)
    }

}