import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class LoginCallback {
  void onLoginSuccess(User user, String token);

  void onLoginError(String error);
}

class LoginRepository {
  LoginCallback _loginCallback;
  UserController _userController = UserController();

  LoginRepository(this._loginCallback);

  void login(String username, String password) async {
    _userController.getUser(username).then((user) {
      if (user.password != password) {
        _loginCallback.onLoginError(Strings.incorrectPassword);
        return;
      }
      var token = '${user.username}_${user.email}_${user.phoneNumber}';
      _loginCallback.onLoginSuccess(user, token);
    }).catchError((error) {
      _loginCallback.onLoginError(Strings.usernameIsNotRegisterYet);
    });
  }
}
