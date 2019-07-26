import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/repository/LoginRepository.dart';
import 'package:learning_local_database/screen/HomeScreen.dart';
import 'package:learning_local_database/screen/RegisterScreen.dart';
import 'package:learning_local_database/screen/ResetPasswordScreen.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseCard.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static void pushAndRemoveUntil(BuildContext context) =>
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (_) => false);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginRepository {
  final _formKey = GlobalKey<FormState>();
  final _sizedBox32 = SizedBox(height: 32.0);
  LoginRepositoryImp _loginRepoImp;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginRepoImp = LoginRepositoryImp(this);
    super.initState();
  }

  @override
  void onLoginSuccess(int userID, String token) {
    SharedPreferencesHelper.saveToken(token);
    SharedPreferencesHelper.saveUserID(userID);
    HomeScreen.pushAndRemoveUntil(context, userID);
  }

  @override
  void onLoginError(String error) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, error, () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          BaseBackground.backgroundRedWhite(),
          _buildLogin(),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return SingleChildScrollView(
      child: BaseCard(
        padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(Strings.login, style: TextStyle(fontSize: 20.0)),
              _sizedBox32,
              BaseTextFormField(
                labelText: Strings.username,
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _usernameFocusNode, _passwordFocusNode),
                validator: (text) => text.isEmpty ? Strings.usernameRequired : null,
              ),
              SizedBox(height: 16.0),
              BaseTextFormField(
                labelText: Strings.password,
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
                validator: (text) => text.isEmpty ? Strings.passwordRequired : null,
              ),
              _sizedBox32,
              Container(
                height: 48.0,
                margin: EdgeInsets.only(bottom: 16.0),
                width: double.infinity,
                child: BaseRaisedButton(
                  text: Strings.login,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    var username = _usernameController.text.trim();
                    var password = _passwordController.text;
                    _loginRepoImp.login(username, password);
                  },
                ),
              ),
              FlatButton(
                onPressed: () => ResetPasswordScreen.push(context),
                child: Text(Strings.forgotPassword, style: TextStyle(color: Colors.red)),
              ),
              FlatButton(
                onPressed: () => RegisterScreen.push(context),
                child: Text(Strings.notYetMemberRegisterHere, style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
