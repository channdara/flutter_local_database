import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class ResetPasswordCallback {
  void onCheckUsernameSuccess(User user);

  void onCheckUsernameError(String error);

  void onResetPasswordSuccess(String message);

  void onResetPasswordError(String error);
}

class ResetPasswordRepository {
  ResetPasswordCallback _resetPasswordCallback;
  UserController _userController = UserController();

  ResetPasswordRepository(this._resetPasswordCallback);

  void checkUsername(String username) {
    _userController.getUser(username).then((user) {
      user == null
          ? _resetPasswordCallback.onCheckUsernameError(Strings.usernameNotFound)
          : _resetPasswordCallback.onCheckUsernameSuccess(user);
    });
  }

  void resetPassword(User user) {
    _userController.updateUser(user).then((isSuccess) {
      isSuccess
          ? _resetPasswordCallback.onResetPasswordSuccess(Strings.yourPasswordHasBeenReset)
          : _resetPasswordCallback.onResetPasswordError(Strings.sorrySomethingWentWrong);
    });
  }
}
