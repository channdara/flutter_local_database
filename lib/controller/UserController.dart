import 'package:learning_local_database/helper/DatabaseHelper.dart';
import 'package:learning_local_database/model/User.dart';

class UserController {
  static final userID = 'user_id';
  static final userName = 'user_name';
  static final userPassword = 'user_password';
  static final userEmail = 'user_email';
  static final userPhoneNumber = 'user_phone_number';
  static final userTable = 'user_table';
  static final userTableSQL = """CREATE TABLE $userTable (
  $userID INTEGER PRIMARY KEY AUTOINCREMENT,
  $userName TEXT NOT NULL,
  $userPassword TEXT NOT NULL,
  $userEmail TEXT NOT NULL,
  $userPhoneNumber TEXT NOT NULL)""";

  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertUser(User user) async {
    var database = await _databaseHelper.database;
    var result = await database.insert(userTable, user.toJson());
    database.close();
    return result;
  }

  Future<int> updateUser(User user) async {
    var database = await _databaseHelper.database;
    var result = await database.update(userTable, user.toJson(), where: '$userID = ?', whereArgs: [user.userID]);
    database.close();
    return result;
  }

  Future<int> deleteUser(int id) async {
    var database = await _databaseHelper.database;
    var result = await database.delete(userTable, where: '$userID = ?', whereArgs: [id]);
    database.close();
    return result;
  }

  Future<List<User>> getAllUsers() async {
    List<User> allUser = [];
    var database = await _databaseHelper.database;
    var result = await database.query(userTable);
    result.forEach((res) => allUser.add(User.fromJson(res)));
    database.close();
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
