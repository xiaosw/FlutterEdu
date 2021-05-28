package com.xsw.edu.flutter

import android.app.Application
import com.xsw.flutter.FlutterManager

/**
 * ClassName: [App]
 * Description:
 *
 * Create by X at 2021/05/28 10:45.
 */
class App : Application() {

    override fun onCreate() {
        super.onCreate()
        FlutterManager.init(this)
    }

}