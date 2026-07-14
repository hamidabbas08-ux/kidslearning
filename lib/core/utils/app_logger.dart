import 'package:flutter/material.dart';

class AppLogger {
  static void info(String message) {
    debugPrint('[KIDS_INFO] ${DateTime.now()}: $message');
  }
  static void error(String message, [dynamic error]) {
    debugPrint('[KIDS_ERROR] $message: $error');
  }
}
