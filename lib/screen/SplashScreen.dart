import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/screen/HomeScreen.dart';
import 'package:learning_local_database/screen/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Image.asset('assets/image/img_data_center.png')),
      ),
    );
  }

  void _checkToken() async {
    var token = await SharedPreferencesHelper.loadToken();
    if (token == null) {
      _startTimer(() => LoginScreen.pushAndRemoveUntil(context));
      return;
    }
    var user = await SharedPreferencesHelper.loadUser();
    _startTimer(() => HomeScreen.pushAndRemoveUntil(context, user));
  }

  void _startTimer(VoidCallback fun) => Timer(Duration(seconds: 2), fun);
}
