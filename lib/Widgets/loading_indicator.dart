import 'package:flutter/material.dart';
import 'package:xo_game/utils/color_manager.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.color, Key? key}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: LinearProgressIndicator(
        minHeight: 1.5,
        color: color ?? ColorsManager.primaryColor,
      ),
    );
  }
}
