import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'user_model.dart';
import 'package:path/path.dart' as p;

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String IMG = 'img';
  static const String TITLE = 'title';
  static const String CATEGORY = 'category';
  static const String USER = 'user';
  static const String PASS = 'pass';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'passGen.db';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER , $IMG TEXT,$TITLE TEXT,$CATEGORY TEXT,$USER TEXT,$PASS TEXT )");
  }

  Future<UserModel> save(employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE, employee.toMap());
    return employee;
  }

  Future<Database> initializeDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = p.join(databasesPath, 'database_user.db');

      var database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) {
          db.execute(
              '''
          create table $TABLE ( 
          $ID INTEGER PRIMARY KEY AUTOINCREMENT, 
          $IMG text not null, 
          $TITLE text not null,
           $CATEGORY text not null,
            $USER text not null,
           $PASS text not null,
           )
        ''');
        },
      );
      // print('------database database : $database');

      return database;
    } catch (e) {
      print("HelloDatabase Error : ${e.toString()}");
      return null;
    }
  }

  Future<List<UserModel>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, IMG, TITLE, CATEGORY, USER, PASS]);
    List<UserModel> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(UserModel.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future<bool> AddRecord(UserModel user_info) async {
    try {
      Database db = await this.db;

      await db.insert(TABLE, user_info.toMap());

      return true;
    } catch (e) {
      print("HelloDatabase Error : ${e.toString()}");
      return false;
    }
  }
}
