import 'package:flutter/material.dart';
import '../utils/app_logger.dart';

class ErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.error("Framework Error Captured", details.exception);
    };
  }

  static Widget buildErrorWidget(BuildContext context, Object error) {
    return const Scaffold(
      body: Center(
        child: Text(
          '✨ Oops! Something magical happened. Let\'s restart! ✨',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
