import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class RegisterCallback {
  void onRegisterSuccess(String message);

  void onRegisterError(String error);
}

class RegisterRepository {
  RegisterCallback _registerCallBack;
  UserController _userController = UserController();

  RegisterRepository(this._registerCallBack);

  void register(User user) {
    _userController.getUserByUsername(user.username).then((res) {
      res != null
          ? _registerCallBack.onRegisterError(Strings.usernameIsAlreadyExist)
          : _userController.insertUser(user).then((isSuccess) {
              isSuccess
                  ? _registerCallBack.onRegisterSuccess(Strings.yourAccountHasBeenRegistered)
                  : _registerCallBack.onRegisterError(Strings.sorrySomethingWentWrong);
            });
    });
  }
}
