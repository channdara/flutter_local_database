import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class RegisterCallBack {
  void onRegisterSuccess(String message);

  void onRegisterError(String error);
}

class RegisterRepository {
  RegisterCallBack _registerCallBack;
  UserController _userController = UserController();

  RegisterRepository(this._registerCallBack);

  void register(User user) {
    _userController.getAllUsers().then((users) {
      users.forEach((res) {
        if (user.username == res.username) {
          _registerCallBack.onRegisterError('Username is already exist.');
          return;
        }
        _userController.insertUser(user).then((isAdded) {
          if (isAdded == 1) {
            _registerCallBack.onRegisterSuccess('${Strings.account}: ${user.username}\n${Strings.yourAccountHasBeenRegistered}');
            return;
          }
          _registerCallBack.onRegisterError(Strings.sorrySomethingWentWrong);
        });
      });
    });
  }
}
