import 'package:flutter/material.dart';
import 'package:xo_game/utils/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.validator,
      this.obsecure = false,
      required this.controller})
      : super(key: key);

  final String label;
  final IconData icon;
  final Function validator;
  final TextEditingController controller;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextFormField(
        obscuringCharacter: '*',
        obscureText: obsecure,
        style: const TextStyle(color: ColorsManager.defaultTextColor),
        controller: controller,
        validator: (value) {
          return validator();
        },
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          fillColor: ColorsManager.primaryColor,
          prefixIcon: Icon(
            icon,
            color: ColorsManager.defaultIconColor,
          ),
          filled: true,
          label: Text(
            label,
            style: const TextStyle(
                color: ColorsManager.defaultTextColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
