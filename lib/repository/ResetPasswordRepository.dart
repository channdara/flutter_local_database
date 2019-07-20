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
      if (user == null) return;
      _resetPasswordCallback.onCheckUsernameSuccess(user);
    }).catchError((error) {
      _resetPasswordCallback.onCheckUsernameError(Strings.usernameNotFound);
    });
  }

  void resetPassword(User user) {
    _userController.updateUser(user).then((isSuccess) {
      if (!isSuccess) return;
      _resetPasswordCallback.onResetPasswordSuccess(Strings.yourPasswordHasBeenReset);
    }).catchError((error) {
      _resetPasswordCallback.onResetPasswordError(Strings.sorrySomethingWentWrong);
    });
  }
}
