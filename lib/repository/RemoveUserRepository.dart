import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/UserController.dart';

abstract class RemoveUserRepository {
  void onRemoveSuccess();

  void onRemoveError(String error);
}

class RemoveUserRepositoryImp {
  RemoveUserRepository _removeUserRepo;
  UserController _userController = UserController();

  RemoveUserRepositoryImp(this._removeUserRepo);

  void removeUser(int id) {
    _userController.deleteUser(id).then((lastIndex) {
      _removeUserRepo.onRemoveSuccess();
    }).catchError((error) {
      _removeUserRepo.onRemoveError(Strings.sorrySomethingWentWrong);
    });
  }
}
