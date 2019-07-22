import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/screen/LoginScreen.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';

class SettingsScreen extends StatefulWidget {
  static void push(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.settings), backgroundColor: Colors.red),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 48.0,
              child: BaseRaisedButton(
                text: Strings.logout,
                onPressed: () => AlertDialogUtil.showConfirmDialog(
                  context,
                  Strings.thinking,
                  Strings.areYouSureYouWantToLogout,
                  () => SharedPreferencesHelper.removeTokenAndUser().then((_) => LoginScreen.pushAndRemoveUntil(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
