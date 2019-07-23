import 'package:learning_local_database/helper/DatabaseHelper.dart';
import 'package:learning_local_database/model/User.dart';

class UserController {
  static final userTable = 'user_table';
  static final userID = 'user_id';
  static final userName = 'user_name';
  static final userPassword = 'user_password';
  static final userEmail = 'user_email';
  static final userPhoneNumber = 'user_phone_number';
  static final userTableSQL = """CREATE TABLE ${UserController.userTable} (
    ${UserController.userID} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${UserController.userName} TEXT NOT NULL,
    ${UserController.userPassword} TEXT NOT NULL,
    ${UserController.userEmail} TEXT NOT NULL,
    ${UserController.userPhoneNumber} TEXT NOT NULL)""";

  DatabaseHelper _databaseHelper = DatabaseHelper(userTableSQL);

  Future<bool> insertUser(User user) async {
    var database = await _databaseHelper.database;
    var result = await database.insert(userTable, user.toJson());
    database.close();
    return result == 1;
  }

  Future<bool> updateUser(User user) async {
    var database = await _databaseHelper.database;
    var result = await database.update(userTable, user.toJson(), where: '$userID = ?', whereArgs: [user.id]);
    database.close();
    return result == 1;
  }

  Future<bool> deleteUser(int id) async {
    var database = await _databaseHelper.database;
    var result = await database.delete(userTable, where: '$userID = ?', whereArgs: [id]);
    database.close();
    return result == 1;
  }

  Future<List<User>> getAllUsers() async {
    List<User> allUser = [];
    var database = await _databaseHelper.database;
    var result = await database.query(userTable);
    result.forEach((res) => allUser.add(User.fromJson(res)));
    return allUser;
  }

  Future<User> getUserByUsername(String username) async {
    var database = await _databaseHelper.database;
    var sql = """SELECT * FROM $userTable WHERE $userName = '$username'""";
    var result = await database.rawQuery(sql);
    database.close();
    return result.isNotEmpty ? User.fromJson(result.first) : null;
  }

  Future<User> getUserByID(int id) async {
    var database = await _databaseHelper.database;
    var sql = """SELECT * FROM $userTable WHERE $userID = '$id'""";
    var result = await database.rawQuery(sql);
    database.close();
    return result.isNotEmpty ? User.fromJson(result.first) : null;
  }
}
