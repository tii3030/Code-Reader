// ignore_for_file: unused_element
// ignore_for_file: constant_identifier_names
// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DaoLogin {

  static const String CREATE_USERS_TABLE_SCRIPT = "CREATE TABLE users(id INTEGER ,code TEXT)";
  static const String DATABASE_NAME = "DB_barcode";
  static const String TABLE_NAME = "users";

  // CREATE DATABASE
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_USERS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  // INSERT IN TABLE
  Future create(User user) async {
    try {
      final Database db = await _getDatabase();
      Map<String, dynamic> transfMap = _toMap(user);

      return await db.insert(
        TABLE_NAME,
        transfMap,
      );

    } catch (ex) {
      print(ex);
      return;
    }
  }

  Map<String, dynamic> _toMap(User user) {
    final Map<String, dynamic> users = Map();
      users['id'] =  user.id;
      users['code'] =  user.code;

    return users;
  }

  Future<List<User>> getUser() async {

    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    List<User> users = _toList(maps);

    return users;
    
  }

  List<User> _toList(List<Map<String, dynamic>> maps) {
    final List<User> users = [];

    for(Map<String, dynamic> row in maps) {
      final User user = User(
        row['id'],
        row['code']
      );

      users.add(user);
    }

    return users;
  }
}