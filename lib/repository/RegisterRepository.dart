import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class RegisterRepository {
  void onRegisterError(String error);

  void onRegisterSuccess(String message);
}

class RegisterRepositoryImp {
  RegisterRepository _registerRepo;
  UserController _userController = UserController();

  RegisterRepositoryImp(this._registerRepo);

  void register(User user) {
    _userController.getUserByUsername(user.username).then((res) {
      if (res != null) {
        _registerRepo.onRegisterError(Strings.usernameIsAlreadyExist);
        return;
      }
      _userController.insertUser(user).then((lastIndex) {
        _registerRepo.onRegisterSuccess(Strings.yourAccountHasBeenRegistered);
      }).catchError((error) {
        _registerRepo.onRegisterError(Strings.sorrySomethingWentWrong);
      });
    });
  }
}
