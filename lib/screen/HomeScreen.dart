import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/screen/AddContactScreen.dart';
import 'package:learning_local_database/screen/SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  static String pushTag = 'HeroPushTag';

  static void pushAndRemoveUntil(BuildContext context, int id) =>
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen(id)), (_) => false);

  final int id;

  HomeScreen(this.id);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _emptyList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(child: _buildListView()),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(Strings.home),
      backgroundColor: Colors.red,
      actions: <Widget>[
        IconButton(
          onPressed: () => SettingsScreen.push(context, widget.id),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => AddContactScreen.push(context),
      backgroundColor: Colors.green,
      heroTag: HomeScreen.pushTag,
      child: Icon(Icons.add),
    );
  }

  Widget _buildListView() {
    return _emptyList.isEmpty
        ? Container(
            padding: EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/image/img_data_center.png'),
                Text('No contact found!', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(top: 16.0),
            itemCount: _emptyList.length,
            itemBuilder: (context, index) => Container(),
          );
  }
}
