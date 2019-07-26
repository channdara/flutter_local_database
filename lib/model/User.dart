import 'package:learning_local_database/controller/UserController.dart';

class User {
  int userID;
  String username;
  String password;
  String email;
  String phoneNumber;

  User.defaultConst({
    this.userID = 0,
    this.username = '',
    this.password = '',
    this.email = '',
    this.phoneNumber = '',
  });

  User({this.userID, this.username, this.password, this.email, this.phoneNumber});

  User.fromJson(Map<String, dynamic> data) {
    this.userID = data[UserController.userID];
    this.username = data[UserController.userName];
    this.password = data[UserController.userPassword];
    this.email = data[UserController.userEmail];
    this.phoneNumber = data[UserController.userPhoneNumber];
  }

  Map<String, dynamic> toJson() => {
        UserController.userID: this.userID,
        UserController.userName: this.username,
        UserController.userPassword: this.password,
        UserController.userEmail: this.email,
        UserController.userPhoneNumber: this.phoneNumber,
      };
}
