import 'package:flutter/material.dart';

class SnackBarHelper {
  // Default duration (can be overridden)
  static int defaultDuration = 500;

  /// Shows a SnackBar with a message
  /// [duration] is optional; if not provided, uses [defaultDuration]
  static void show(
    BuildContext context,
    String message, {
    int? durationInMilliSeconds,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(
          milliseconds: durationInMilliSeconds ?? defaultDuration,
        ),
        behavior: behavior,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
