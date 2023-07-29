import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatebaseProvider extends ChangeNotifier {
  List<DeviceProfile> _profileList = [];
  List<DeviceProfile> get profileList => _profileList;
  Database? _database;

  static const dTable = "device";
  Future<Database> get database async {
    final dbDirectry = await getDatabasesPath();
    const dbName = "deviceProfile.db";
    final path = join(dbDirectry, dbName);
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE $dTable (
          name TEXT,
          lat TEXT,
          long TEXT,
          appBarColor TEXT,
          appTextColor TEXT,
          backgroundColor TEXT,
          primaryColor TEXT,
          secondryColor TEXT,
          buttonColor TEXT,
          buttonTextColor TEXT,
          primaryText TEXT,
          secondryText TEXT,
          defultProfile BOOLEAN)
        ''');
    });
  }

  Future<List<DeviceProfile>> fetchData() async {
    final db = await database;

    return await db.transaction((txn) async {
      return await txn.query(dTable).then((value) {
        final converted = List<Map<String, dynamic>>.from(value);
        List<DeviceProfile> list = List.generate(converted.length, (index) => DeviceProfile.fromMap(converted[index]));
        _profileList = list;
        return _profileList;
      });
    });
  }

  Future<void> addData(DeviceProfile data) async {
    final db = await database;

    return await db.transaction((txn) async {
      return await txn.insert(dTable, data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
        log("enter the value");
      });
    });
  }

  Future<bool> getProfile(String lat, String long) async {
    final db = await database;
    final maps = await db.query(dTable, where: 'lat = ?', whereArgs: [lat]);
    if (maps.isNotEmpty) {
      final map1 = await db.query(dTable, where: 'long = ?', whereArgs: [long]);
      return map1.isNotEmpty ? true : false;
    }
    return false;
  }
}
