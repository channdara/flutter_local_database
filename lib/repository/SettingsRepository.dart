import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/ContactController.dart';
import 'package:learning_local_database/controller/UserController.dart';

abstract class SettingsRepository {
  void onRemoveError(String error);

  void onRemoveSuccess();
}

class SettingsRepositoryImp {
  SettingsRepository _removeUserRepo;
  UserController _userController = UserController();
  ContactController _contactController = ContactController();

  SettingsRepositoryImp(this._removeUserRepo);

  void removeUser(int userID) {
    _userController.deleteUser(userID).then((lastIndex) {
      _removeUserRepo.onRemoveSuccess();
    }).catchError((error) {
      _removeUserRepo.onRemoveError(Strings.sorrySomethingWentWrong);
    });
    _contactController.deleteContactsByUserID(userID).then((lasIndex) {
      _removeUserRepo.onRemoveSuccess();
    }).catchError((error) {
      _removeUserRepo.onRemoveError(error);
    });
  }
}
