import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/ContactController.dart';
import 'package:learning_local_database/model/Contact.dart';

abstract class HomeRepository {
  void onError(String error);

  void onLoadContactsSuccess(List<Contact> contacts);

  void onDeleteContactSuccess(String message);
}

class HomeRepositoryImp {
  HomeRepository _homeRepo;
  ContactController _contactController = ContactController();

  HomeRepositoryImp(this._homeRepo);

  void getAllContactsByUserID(int userID) {
    _contactController.getAllContactsByUserID(userID).then((contacts) {
      _homeRepo.onLoadContactsSuccess(contacts);
    }).catchError((error) {
      _homeRepo.onError(Strings.sorrySomethingWentWrong);
    });
  }

  void deleteContact(int contactID) {
    _contactController.deleteContact(contactID).then((lastIndex) {
      _homeRepo.onDeleteContactSuccess('Contact has been removed.');
    }).catchError((error) {
      _homeRepo.onError(Strings.sorrySomethingWentWrong);
    });
  }
}
