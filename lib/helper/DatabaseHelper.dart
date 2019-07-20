import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _sql;
  final _databaseName = 'MyAppDatabase.db';
  final _databaseVersion = 1;

  DatabaseHelper(this._sql);

  Future<Database> get database async {
    var document = await getApplicationDocumentsDirectory();
    var path = join(document.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: (db, version) => db.execute(_sql));
  }
}
