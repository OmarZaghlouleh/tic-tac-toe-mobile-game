import 'package:flutter/material.dart';
import 'package:xo_game/utils/color_manager.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.color, Key? key}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: color ?? ColorsManager.primaryColor,
    );
  }
}
