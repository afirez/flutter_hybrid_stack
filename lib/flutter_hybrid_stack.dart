
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterHybridStack {
  static const MethodChannel _channel = MethodChannel('flutter_hybrid_stack');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

