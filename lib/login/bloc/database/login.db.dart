import 'dart:io';

import 'package:facebook_login/login/bloc/model/user.model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LoginDatabase {
  LoginDatabase._();

  static final LoginDatabase db = LoginDatabase._();
  Database _database;
  String loginTableName = "login_table";

  String dbName = "app.db";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    return await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
      initiateLoginTable(db);
    });
  }

  initiateLoginTable(Database db) async {
    await db.execute("CREATE TABLE $loginTableName ("
        "name TEXT,"
        "email TEXT"
        ")");
  }

  Future<int> insertUser(UserModel userModel) async {
    final db = await database;
    var raw = await db.insert(
      loginTableName,
      userModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    print("inserted: $raw");
    return raw;
  }

  Future<UserModel> getLoggedInUser() async {
    final db = await database;
    var response = await db.query(loginTableName);
    if (response != null && response.length > 0)
      return UserModel.fromMap(response[0]);
    else
      return null;
  }
}
