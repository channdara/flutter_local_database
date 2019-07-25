import 'package:learning_local_database/controller/ContactController.dart';

class Contact {
  int contactID;
  int userID;
  String imagePath;
  String contactName;
  String contactNumber;

  Contact.defaultConst({
    this.contactID = 0,
    this.userID = 0,
    this.imagePath = '',
    this.contactName = '',
    this.contactNumber = '',
  });

  Contact({this.contactID, this.userID, this.imagePath, this.contactName, this.contactNumber});

  Contact.fromJson(Map<String, dynamic> data) {
    this.contactID = data[ContactController.contactID];
    this.userID = data[ContactController.userID];
    this.imagePath = data[ContactController.contactImagePath];
    this.contactName = data[ContactController.contactName];
    this.contactNumber = data[ContactController.contactNumber];
  }

  Map<String, dynamic> toJson() => {
        ContactController.contactID: this.contactID,
        ContactController.userID: this.userID,
        ContactController.contactImagePath: this.imagePath,
        ContactController.contactName: this.contactName,
        ContactController.contactNumber: this.contactNumber,
      };
}
