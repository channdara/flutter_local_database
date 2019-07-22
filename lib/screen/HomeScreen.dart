import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/screen/SettingsScreen.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';

class HomeScreen extends StatefulWidget {
  static void pushAndRemoveUntil(BuildContext context, int id) =>
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen(id)), (_) => false);

  final int id;

  HomeScreen(this.id);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(
        title: Text(Strings.home),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            onPressed: () => SettingsScreen.push(context, widget.id),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
