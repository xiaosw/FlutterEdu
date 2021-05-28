import 'dart:io';

import 'package:flutter/services.dart';

class Utils {
  static bool isNull(Object obj) {
    return null == obj;
  }

  static bool hasNull([ dynamic arguments ]) {
    for (var arg in arguments) {
      if(isNull(arg)) {
        return true;
      }
    }
    return false;
  }

}

class PlatformLog {
  static const MethodChannel _platformLog = const MethodChannel("com.xsw.flutter/log");
  static const _KEY_TAG = "tag";
  static const _KEY_MESSAGE = "message";

  static void v(String tag, String message) {
    _log("v", tag, message);
  }

  static void d(String tag, String message) {
    _log("d", tag, message);
  }

  static void i(String tag, String message) {
    _log("i", tag, message);
  }

  static void w(String tag, String message) {
    _log("w", tag, message);
  }

  static void e(String tag, String message) {
    _log("e", tag, message);
  }

  static void _log(String method, String tag, String message) {
    try {
      _platformLog.invokeMethod(method, {_KEY_TAG : tag, _KEY_MESSAGE : message});
    } on Exception {
      // noting
    }
  }
}