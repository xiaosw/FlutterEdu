package com.xsw.flutter.plugin

/**
 * ClassName: [PluginNameProvider]
 * Description:
 *
 * Create by X at 2021/05/28 15:19.
 */
interface PluginNameProvider {
    
    val name: String
        get() = providerPackageName() + providerName()

    fun providerPackageName() : String
    
    fun providerName() : String
    
}