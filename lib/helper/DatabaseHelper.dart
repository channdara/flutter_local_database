import 'package:learning_local_database/controller/ContactController.dart';
import 'package:learning_local_database/controller/UserController.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = 'MyAppDatabase.db';
  final _databaseVersion = 1;

  Future<Database> get database async {
    var document = await getApplicationDocumentsDirectory();
    var path = join(document.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: (db, version) {
      db.execute(UserController.userTableSQL);
      db.execute(ContactController.contactTableSQL);
    });
  }
}
