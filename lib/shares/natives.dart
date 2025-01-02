import 'package:flutter/services.dart';

class Natives {
  static Future<void> androidBackDesktop() async {
    try {
      await MethodChannel("usemain/backChannel").invokeMethod('backDesktop');
    } on PlatformException {
      SystemNavigator.pop();
    }
  }
}
