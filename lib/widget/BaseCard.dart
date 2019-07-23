import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  BaseCard({
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: this.margin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(padding: this.padding, child: this.child),
    );
  }
}
