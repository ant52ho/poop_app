import 'package:flutter/services.dart';

class NativeCommunication {
  static const MethodChannel _platformChannel =
      MethodChannel('poop.anthony.channel');

  // reload widget trigger
  Future<void> reloadWidget() async {
    try {
      await _platformChannel.invokeMethod('reloadWidget');
    } on PlatformException catch (e) {
      print("Failed to reload widget: ${e.message}");
    }
  }
}
