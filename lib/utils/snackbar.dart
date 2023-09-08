import 'package:flutter/material.dart';
import 'package:xo_game/utils/color_manager.dart';

void showSnackbar(
    {required BuildContext context,
    required String message,
    required bool success}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          success ? ColorsManager.successColor : ColorsManager.failColor,
      content: Text(message),
    ),
  );
}
