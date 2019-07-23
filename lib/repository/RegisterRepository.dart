import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/model/User.dart';

abstract class RegisterRepository {
  void onRegisterSuccess(String message);

  void onRegisterError(String error);
}

class RegisterRepositoryImp {
  RegisterRepository _registerRepo;
  UserController _userController = UserController();

  RegisterRepositoryImp(this._registerRepo);

  void register(User user) {
    _userController.getUserByUsername(user.username).then((res) {
      res != null
          ? _registerRepo.onRegisterError(Strings.usernameIsAlreadyExist)
          : _userController.insertUser(user).then((isSuccess) {
              isSuccess
                  ? _registerRepo.onRegisterSuccess(Strings.yourAccountHasBeenRegistered)
                  : _registerRepo.onRegisterError(Strings.sorrySomethingWentWrong);
            });
    });
  }
}
