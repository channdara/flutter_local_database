import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  final AppBar appBar;
  final Widget body;

  BaseContainer({this.appBar, this.body});

  @override
  State createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(child: widget.body),
    );
  }
}
