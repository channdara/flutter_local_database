import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';

class AlertDialogUtil {
  static void showAlertDialog(BuildContext context, String title, String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        actions: <Widget>[BaseRaisedButton(text: Strings.ok, fontSize: 16.0, onPressed: onPressed)],
      ),
    );
  }

  static void showConfirmDialog(BuildContext context, String title, String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        actions: <Widget>[
          BaseRaisedButton(text: Strings.cancel, fontSize: 16.0, onPressed: () => Navigator.pop(context)),
          BaseRaisedButton(text: Strings.ok, fontSize: 16.0, color: Colors.green, onPressed: onPressed),
        ],
      ),
    );
  }

  static void showSelectImageDialog(
    BuildContext context,
    String title,
    String content, {
    VoidCallback onCameraPressed,
    VoidCallback onGalleryPressed,
    VoidCallback onRemovePressed,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        actions: <Widget>[
          BaseRaisedButton(text: Strings.remove, fontSize: 16.0, color: Colors.red, onPressed: onRemovePressed),
          BaseRaisedButton(text: Strings.fromCamera, fontSize: 16.0, color: Colors.blue, onPressed: onCameraPressed),
          BaseRaisedButton(text: Strings.fromGallery, fontSize: 16.0, color: Colors.green, onPressed: onGalleryPressed),
        ],
      ),
    );
  }
}
