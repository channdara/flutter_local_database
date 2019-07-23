import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/repository/RegisterRepository.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class RegisterScreen extends StatefulWidget {
  static void push(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterRepository {
  final _formKey = GlobalKey<FormState>();
  final _sizedBox = SizedBox(height: 16.0);
  RegisterRepositoryImp _registerRepoImp;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _registerRepoImp = RegisterRepositoryImp(this);
    super.initState();
  }

  @override
  void onRegisterSuccess(String message) {
    AlertDialogUtil.showAlertDialog(context, Strings.congratulation, message, () {
      _usernameController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
      _emailController.text = '';
      _phoneNumberController.text = '';
      Navigator.pop(context);
    });
  }

  @override
  void onRegisterError(String error) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, error, () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.registerForm), backgroundColor: Colors.red),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          BaseBackground.backgroundRedWhite(),
          _buildRegister(),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              BaseTextFormField(
                labelText: Strings.username,
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _usernameFocusNode, _passwordFocusNode),
                validator: (text) => text.isEmpty ? Strings.pleaseInputUsername : null,
              ),
              _sizedBox,
              BaseTextFormField(
                labelText: Strings.password,
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _passwordFocusNode, _confirmPasswordFocusNode),
                validator: (text) => text.isEmpty ? Strings.pleaseInputPassword : null,
              ),
              _sizedBox,
              BaseTextFormField(
                labelText: Strings.confirmPassword,
                obscureText: true,
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _confirmPasswordFocusNode, _emailFocusNode),
                validator: (text) {
                  if (text.isEmpty) return Strings.pleaseInputConfirmPassword;
                  if (_confirmPasswordController.text != _passwordController.text) return Strings.confirmPasswordDoesNotMatch;
                  return null;
                },
              ),
              _sizedBox,
              BaseTextFormField(
                labelText: Strings.email,
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _emailFocusNode, _phoneNumberFocusNode),
                validator: (text) => text.isEmpty ? Strings.pleaseInputEmail : null,
              ),
              _sizedBox,
              BaseTextFormField(
                labelText: Strings.phoneNumber,
                controller: _phoneNumberController,
                textInputType: TextInputType.number,
                focusNode: _phoneNumberFocusNode,
                textInputAction: TextInputAction.done,
                validator: (text) => text.isEmpty ? Strings.pleaseInputPhoneNumber : null,
              ),
              _sizedBox,
              InkWell(
                onTap: () => Platform.isIOS ? FocusScope.of(context).requestFocus(FocusNode()) : null,
                child: Text(
                  Strings.privacyPolicy,
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32.0),
                width: double.infinity,
                height: 48.0,
                child: BaseRaisedButton(
                  text: Strings.register,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    var user = User(
                      username: _usernameController.text.trim(),
                      password: _confirmPasswordController.text,
                      email: _emailController.text.trim(),
                      phoneNumber: _phoneNumberController.text,
                    );
                    _registerRepoImp.register(user);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
