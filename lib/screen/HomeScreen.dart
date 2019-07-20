import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/screen/LoginScreen.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';

class HomeScreen extends StatefulWidget {
  static void pushReplacement(BuildContext context, User user) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(user)));

  final User user;

  HomeScreen(this.user);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.home), backgroundColor: Colors.red),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: BaseRaisedButton(
          text: Strings.logout,
          onPressed: () {
            SharedPreferencesHelper.removeTokenAndUser().then((_) => LoginScreen.pushReplacement(context));
          },
        ),
      ),
    );
  }
}
