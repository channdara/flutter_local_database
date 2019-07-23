import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/repository/RemoveUserRepository.dart';
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

class _SettingsScreenState extends State<SettingsScreen> implements RemoveUserRepository {
  final _sizedBox16 = SizedBox(height: 16.0);
  User _user = User.defaultConstructor();
  RemoveUserRepositoryImp _removeUserRepositoryImp;

  @override
  void initState() {
    _removeUserRepositoryImp = RemoveUserRepositoryImp(this);
    _getUserFromDatabase();
    super.initState();
  }

  @override
  void onRemoveSuccess() {
    _logout();
  }

  @override
  void onRemoveError(String error) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, error, () => Navigator.pop(context));
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
        child: Column(
          children: <Widget>[
            BaseCard(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: _buildListTileIcon('ic_user'),
                    title: Text(_user.username),
                    subtitle: Text(Strings.username),
                  ),
                  ListTile(
                    leading: _buildListTileIcon('ic_password'),
                    title: Text('********'),
                    subtitle: Text(Strings.password),
                  ),
                  ListTile(
                    leading: _buildListTileIcon('ic_email'),
                    title: Text(_user.email),
                    subtitle: Text(Strings.email),
                  ),
                  ListTile(
                    leading: _buildListTileIcon('ic_phone'),
                    title: Text(_user.phoneNumber),
                    subtitle: Text(Strings.phoneNumber),
                  ),
                ],
              ),
            ),
            _sizedBox16,
            BaseCard(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              color: Colors.red[100],
              child: ListTile(
                leading: _buildListTileIcon('ic_user'),
                title: Text(Strings.removeThisAccount),
                subtitle: Text(Strings.longPressToRemove),
                onLongPress: () => AlertDialogUtil.showConfirmDialog(
                  context,
                  Strings.thinking,
                  Strings.areYouSureYouWantToRemoveThisAccount,
                  () {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 500), () {
                      _removeUserRepositoryImp.removeUser(widget.id);
                    });
                  },
                ),
              ),
            ),
          ],
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
          () => _logout(),
        ),
      ),
    );
  }

  Widget _buildListTileIcon(String asset) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(4.0),
      child: Image.asset('assets/image/$asset.png'),
    );
  }

  void _getUserFromDatabase() async {
    UserController().getUserByID(widget.id).then((user) {
      if (user == null) return;
      this._user = user;
      setState(() {});
    });
  }

  void _logout() {
    SharedPreferencesHelper.removeTokenAndUser().then((_) => LoginScreen.pushAndRemoveUntil(context));
  }
}
