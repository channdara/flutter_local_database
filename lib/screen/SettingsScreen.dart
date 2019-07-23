import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/screen/LoginScreen.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseCard.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';

class SettingsScreen extends StatefulWidget {
  static void push(BuildContext context, int id) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen(id)));

  final int id;

  SettingsScreen(this.id);

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User _user = User.defaultConstructor();

  @override
  void initState() {
    _getUserFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.settings), backgroundColor: Colors.red),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildUserInformation(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInformation() {
    return Expanded(
      child: SingleChildScrollView(
        child: BaseCard(
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.supervised_user_circle, size: 40.0),
                title: Text(_user.username),
                subtitle: Text(Strings.username),
              ),
              ListTile(
                leading: Icon(Icons.vpn_key, size: 40.0),
                title: Text('********'),
                subtitle: Text(Strings.password),
              ),
              ListTile(
                leading: Icon(Icons.email, size: 40.0),
                title: Text(_user.email),
                subtitle: Text(Strings.email),
              ),
              ListTile(
                leading: Icon(Icons.phone, size: 40.0),
                title: Text(_user.phoneNumber),
                subtitle: Text(Strings.phoneNumber),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
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
    );
  }

  void _getUserFromDatabase() async {
    UserController().getUserByID(widget.id).then((user) {
      if (user == null) return;
      this._user = user;
      setState(() {});
    });
  }
}
