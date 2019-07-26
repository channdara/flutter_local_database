import 'package:learning_local_database/controller/UserController.dart';
import 'package:learning_local_database/helper/DatabaseHelper.dart';
import 'package:learning_local_database/model/Contact.dart';

class ContactController {
  static final contactID = 'contact_id';
  static final userID = UserController.userID;
  static final contactImagePath = 'contact_image_path';
  static final contactName = 'contact_name';
  static final contactNumber = 'contact_number';
  static final contactTable = 'contact_table';
  static final contactTableSQL = """CREATE TABLE $contactTable (
  $contactID INTEGER PRIMARY KEY AUTOINCREMENT,
  $userID INTEGER NOT NULL,
  $contactImagePath TEXT NOT NULL,
  $contactName TEXT NOT NULL,
  $contactNumber TEXT NOT NULL)""";

  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertContact(Contact contact) async {
    var database = await _databaseHelper.database;
    var result = await database.insert(contactTable, contact.toJson());
    database.close();
    return result;
  }

  Future<int> updateContact(Contact contact) async {
    var database = await _databaseHelper.database;
    var result = await database.update(contactTable, contact.toJson(), where: '$contactID = ?', whereArgs: [contact.contactID]);
    database.close();
    return result;
  }

  Future<int> deleteContact(int id) async {
    var database = await _databaseHelper.database;
    var result = await database.delete(contactTable, where: '$contactID = ?', whereArgs: [id]);
    database.close();
    return result;
  }

  Future<int> deleteContactsByUserID(int id) async {
    var database = await _databaseHelper.database;
    var result = await database.delete(contactTable, where: '$userID = ?', whereArgs: [id]);
    database.close();
    return result;
  }

  Future<List<Contact>> getAllContactsByUserID(int id) async {
    List<Contact> allContacts = [];
    List<Contact> allContactsByUser = [];
    var database = await _databaseHelper.database;
    var result = await database.query(contactTable);
    if (result == null) {
      database.close();
      return allContactsByUser;
    }
    result.forEach((res) => allContacts.add(Contact.fromJson(res)));
    allContactsByUser = allContacts.where((con) => con.userID == id).toList();
    allContactsByUser.sort((a, b) => a.contactName.compareTo(b.contactName));
    database.close();
    return allContactsByUser;
  }
}
