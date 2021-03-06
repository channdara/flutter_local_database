import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_local_database/screen/SplashScreen.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  State createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ProductSans'),
      home: SplashScreen(),
    );
  }
}
