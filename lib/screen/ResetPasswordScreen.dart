import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/model/User.dart';
import 'package:learning_local_database/repository/ResetPasswordRepository.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseCard.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class ResetPasswordScreen extends StatefulWidget {
  static void push(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));

  @override
  State createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> implements ResetPasswordRepository {
  final _formResetPasswordKey = GlobalKey<FormState>();
  final _formCheckUsernameKey = GlobalKey<FormState>();
  final _sizedBox = SizedBox(height: 16.0);
  User _user;
  bool _isUsernameChecked = false;
  bool _isEnabled = true;
  ResetPasswordRepositoryImp _resetPasswordRepoImp;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _resetPasswordRepoImp = ResetPasswordRepositoryImp(this);
    super.initState();
  }

  @override
  void onError(String error) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, error, () => Navigator.pop(context));
  }

  @override
  void onCheckUsernameSuccess(User user) {
    _isUsernameChecked = true;
    _isEnabled = false;
    _user = user;
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  @override
  void onResetPasswordSuccess(String message) {
    AlertDialogUtil.showAlertDialog(context, Strings.congratulation, message, () {
      _usernameController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
      _isUsernameChecked = false;
      _isEnabled = true;
      Navigator.pop(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.resetPassword), backgroundColor: Colors.red),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          BaseBackground.backgroundRedWhite(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: BaseCard(
        child: Column(
          children: <Widget>[
            _buildCheckUsername(),
            SizedBox(height: 64.0),
            _buildResetPassword(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckUsername() {
    return Form(
      key: _formCheckUsernameKey,
      child: Column(
        children: <Widget>[
          BaseTextFormField(
            labelText: Strings.username,
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            enabled: _isEnabled,
            validator: (text) => text.isEmpty ? Strings.usernameRequired : null,
          ),
          _sizedBox,
          Container(
            width: double.infinity,
            height: 48.0,
            child: BaseRaisedButton(
              text: Strings.checkUsername,
              onPressed: _isEnabled
                  ? () {
                      if (!_formCheckUsernameKey.currentState.validate()) return;
                      _resetPasswordRepoImp.checkUsername(_usernameController.text.trim());
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPassword() {
    return Form(
      key: _formResetPasswordKey,
      child: Column(
        children: <Widget>[
          BaseTextFormField(
            labelText: Strings.password,
            obscureText: true,
            enabled: _isUsernameChecked,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _passwordFocusNode, _confirmPasswordFocusNode),
            validator: (text) => text.isEmpty ? Strings.pleaseInputNewPassword : null,
          ),
          _sizedBox,
          BaseTextFormField(
            labelText: Strings.confirmPassword,
            obscureText: true,
            controller: _confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            textInputAction: TextInputAction.done,
            enabled: _isUsernameChecked,
            validator: (text) {
              if (text.isEmpty) return Strings.pleaseInputNewConfirmPassword;
              if (_confirmPasswordController.text != _passwordController.text) return Strings.confirmPasswordDoesNotMatch;
              return null;
            },
          ),
          _sizedBox,
          Container(
            width: double.infinity,
            height: 48.0,
            child: BaseRaisedButton(
              text: Strings.resetNow,
              onPressed: _isUsernameChecked
                  ? () {
                      if (!_formResetPasswordKey.currentState.validate()) return;
                      _user.password = _confirmPasswordController.text;
                      _resetPasswordRepoImp.resetPassword(_user);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
