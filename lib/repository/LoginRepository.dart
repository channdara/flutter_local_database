import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';

abstract class LoginRepository {
  void onLoginSuccess(int id, String token);

  void onLoginError(String error);
}

class LoginRepositoryImp {
  LoginRepository _loginRepo;
  UserController _userController = UserController();

  LoginRepositoryImp(this._loginRepo);

  void login(String username, String password) async {
    _userController.getUserByUsername(username).then((user) {
      if (user == null) {
        _loginRepo.onLoginError(Strings.usernameNotFound);
        return;
      }
      if (user.password != password) {
        _loginRepo.onLoginError(Strings.incorrectPassword);
        return;
      }
      var token = '${user.username}_${user.email}_${user.phoneNumber}';
      _loginRepo.onLoginSuccess(user.id, token);
    });
  }
}
