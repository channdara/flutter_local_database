import 'package:flutter/material.dart';

class BaseRaisedButton extends ButtonTheme {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final Color color;

  BaseRaisedButton({
    @required this.text,
    this.fontSize = 20.0,
    this.onPressed,
    this.color = Colors.red,
  }) : super(
          child: RaisedButton(
            onPressed: onPressed,
            child: Text(text, style: TextStyle(fontSize: fontSize, color: Colors.white)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: color,
          ),
        );
}
