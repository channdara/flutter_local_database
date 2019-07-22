import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/helper/SharedPreferencesHelper.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/repository/LoginRepository.dart';
import 'package:learning_local_database/screen/HomeScreen.dart';
import 'package:learning_local_database/screen/RegisterScreen.dart';
import 'package:learning_local_database/screen/ResetPasswordScreen.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static void pushAndRemoveUntil(BuildContext context) =>
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (_) => false);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginCallback {
  final _formKey = GlobalKey<FormState>();
  LoginRepository _loginRepository;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginRepository = LoginRepository(this);
    super.initState();
  }

  @override
  void onLoginSuccess(User user, String token) {
    SharedPreferencesHelper.saveToken(token);
    SharedPreferencesHelper.saveUser(user);
    HomeScreen.pushAndRemoveUntil(context, user);
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
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(Strings.login, style: TextStyle(fontSize: 20.0)),
              Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: BaseTextFormField(
                  labelText: Strings.username,
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _usernameFocusNode, _passwordFocusNode),
                  validator: (text) => text.isEmpty ? Strings.usernameRequired : null,
                ),
              ),
              BaseTextFormField(
                labelText: Strings.password,
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
                validator: (text) => text.isEmpty ? Strings.passwordRequired : null,
              ),
              Container(
                width: double.infinity,
                height: 48.0,
                margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                child: BaseRaisedButton(
                  text: Strings.login,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    _loginRepository.login(username, password);
                  },
                ),
              ),
              InkWell(
                onTap: () => ResetPasswordScreen.push(context),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(Strings.forgotPassword, style: TextStyle(color: Colors.red)),
                ),
              ),
              InkWell(
                onTap: () => RegisterScreen.push(context),
                child: Container(
                  margin: EdgeInsets.only(top: 24.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(Strings.notYetMemberRegisterHere, style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
