import 'package:flutter/material.dart';

class BaseTextFormField extends TextFormField {
  final double fontSize;
  final String labelText;
  final bool obscureText;
  final bool enabled;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  BaseTextFormField({
    this.labelText,
    this.fontSize = 16.0,
    this.controller,
    this.validator,
    this.textInputType,
    this.obscureText = false,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.onFieldSubmitted,
  }) : super(
          decoration: InputDecoration(labelText: labelText, border: OutlineInputBorder()),
          style: TextStyle(fontSize: fontSize),
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
        );

  static void switchNode(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}
