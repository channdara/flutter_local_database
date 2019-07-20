import 'package:learning_local_database/controller/UserController.dart';

class User {
  int id;
  String username;
  String password;
  String email;
  String phoneNumber;

  User({this.id, this.username, this.password, this.email, this.phoneNumber});

  User.fromJson(Map<String, dynamic> data) {
    this.id = data[UserController.userID];
    this.username = data[UserController.userName];
    this.password = data[UserController.userPassword];
    this.email = data[UserController.userEmail];
    this.phoneNumber = data[UserController.userPhoneNumber];
  }

  Map<String, dynamic> toJson() => {
        UserController.userID: this.id,
        UserController.userName: this.username,
        UserController.userPassword: this.password,
        UserController.userEmail: this.email,
        UserController.userPhoneNumber: this.phoneNumber,
      };
}
