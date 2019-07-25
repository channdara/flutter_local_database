import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/controller/ContactController.dart';
import 'package:learning_local_database/model/Contact.dart';

abstract class AddContactRepository {
  void onError(String error);

  void onAddContactSuccess();

  void onUpdateContactSuccess(String message);
}

class AddContactRepositoryImp {
  AddContactRepository _contactRepo;
  ContactController _contactController = ContactController();

  AddContactRepositoryImp(this._contactRepo);

  void insertContact(Contact contact) {
    _contactController.insertContact(contact).then((lastIndex) {
      _contactRepo.onAddContactSuccess();
    }).catchError((error) {
      _contactRepo.onError(Strings.sorrySomethingWentWrong);
    });
  }

  void updateContact(Contact contact) {
    _contactController.updateContact(contact).then((lastIndex) {
      _contactRepo.onUpdateContactSuccess('Contact update successful.');
    }).catchError((error) {
      _contactRepo.onError(Strings.sorrySomethingWentWrong);
    });
  }
}
