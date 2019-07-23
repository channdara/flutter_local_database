import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class ResetPasswordRepository {
  void onCheckUsernameSuccess(User user);

  void onCheckUsernameError(String error);

  void onResetPasswordSuccess(String message);

  void onResetPasswordError(String error);
}

class ResetPasswordRepositoryImp {
  ResetPasswordRepository _resetPasswordRepo;
  UserController _userController = UserController();

  ResetPasswordRepositoryImp(this._resetPasswordRepo);

  void checkUsername(String username) {
    _userController.getUserByUsername(username).then((user) {
      if (user == null) {
        _resetPasswordRepo.onCheckUsernameError(Strings.usernameNotFound);
        return;
      }
      _resetPasswordRepo.onCheckUsernameSuccess(user);
    });
  }

  void resetPassword(User user) {
    _userController.updateUser(user).then((lastIndex) {
      _resetPasswordRepo.onResetPasswordSuccess(Strings.yourPasswordHasBeenReset);
    }).catchError((error) {
      _resetPasswordRepo.onResetPasswordError(Strings.sorrySomethingWentWrong);
    });
  }
}
