import 'package:flutter/material.dart';

import 'package:ru_agenda/app/theme/color_theme.dart';

class RoundedInputField extends StatelessWidget {
  RoundedInputField({
    this.key,
    this.controller,
    this.onFieldSubmitted,
    this.style,
    this.maxLines,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.initialValue,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    this.validator,
    this.keyboardType,
  });

  final Key key;
  final TextEditingController controller;
  final Function onFieldSubmitted;
  final TextStyle style;
  final int maxLines;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String initialValue;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      decoration: InputDecoration(
        filled: true,
        fillColor: kPrimaryLightColor,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      style: style,
      maxLines: maxLines,
      obscureText: obscureText,
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
     // textInputAction: TextInputAction.done,
    );
  }
}
