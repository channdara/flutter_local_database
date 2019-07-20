import 'package:flutter/material.dart';

class BaseBackground {
  static Widget backgroundRedWhite() {
    return Column(
      children: <Widget>[
        Expanded(child: Container(color: Colors.red)),
        Expanded(child: Container()),
      ],
    );
  }
}
