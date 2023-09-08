import 'package:flutter/material.dart';
import 'package:xo_game/utils/extensions.dart';

import '../utils/color_manager.dart';
import '../utils/theme_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.width = 250})
      : super(key: key);

  final String title;
  final IconData icon;
  final Function? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: width,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              onPressed == null
                  ? ColorsManager.disabledColor
                  : const Color(0xff6a040f),
            ),
          ),
          onPressed: onPressed == null
              ? null
              : () {
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: ColorsManager.defaultIconColor,
                  size: 30,
                ),
                10.space(),
                Text(title, style: ThemeManager.defaultTextStyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
