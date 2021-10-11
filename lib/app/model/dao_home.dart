// ignore_for_file: unused_element
// ignore_for_file: constant_identifier_names
// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'barcode.dart';

class DaoHome {

  static const String CREATE_USERS_TABLE_SCRIPT = "CREATE TABLE barcodes(id INTEGER , code TEXT, barcode TEXT)";
  static const String DATABASE_NAME = "DB_barcode";
  static const String TABLE_NAME = "barcodes";

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
  Future create(Barcode barcode) async {
    try {
      final Database db = await _getDatabase();
      Map<String, dynamic> transfMap = _toMap(barcode);

      return await db.insert(
        TABLE_NAME,
        transfMap,
      );

    } catch (ex) {
      print(ex);
      return;
    }
  }

  Map<String, dynamic> _toMap(Barcode barcode) {
    final Map<String, dynamic> barcodes = Map();
      barcodes['id'] =  barcode.id;
      barcodes['code'] =  barcode.code;
      barcodes['barcode'] =  barcode.code;

    return barcodes;
  }

  Future<List<Barcode>> getAll() async {

    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    List<Barcode> barcodes = _toList(maps);

    return barcodes;
    
  }

  List<Barcode> _toList(List<Map<String, dynamic>> maps) {
    final List<Barcode> barcodes = [];

    for(Map<String, dynamic> row in maps) {
      final Barcode user = Barcode(
        row['id'],
        row['code'],
        row['barcode'],

      );

      barcodes.add(user);
    }

    return barcodes;
  }
}