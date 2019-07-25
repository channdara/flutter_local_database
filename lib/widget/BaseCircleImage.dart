import 'package:flutter/material.dart';

class BaseCircleImage extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;

  BaseCircleImage({
    @required this.height,
    @required this.width,
    @required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
        image: DecorationImage(image: ExactAssetImage(this.imagePath), fit: BoxFit.cover),
      ),
    );
  }
}
