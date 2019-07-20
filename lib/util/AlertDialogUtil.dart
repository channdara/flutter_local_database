import 'package:flutter/material.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';

class AlertDialogUtil {
  static void showAlertDialog(BuildContext context, String title, String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[BaseRaisedButton(text: 'OK', fontSize: 16.0, onPressed: onPressed)],
      ),
    );
  }
}
