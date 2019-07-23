import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final AppBar appBar;
  final Widget body;

  BaseContainer({this.appBar, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      body: SafeArea(child: this.body),
    );
  }
}
