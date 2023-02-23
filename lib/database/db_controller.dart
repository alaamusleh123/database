
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController{
  static final DbController _instance= DbController._();
  late Database _database;

  factory DbController(){
    return _instance;
  }
  DbController._();
  Database get database =>_database;
  Future<void> initDatabase() async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= join(directory.path,'db.sql');
    _database= await openDatabase(path,
      version: 2,
      onOpen: (Database db){},
      onCreate: (Database db, int version)async{
      await db.execute('CREATE TABLE users('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name Text,'
        'email Text,'
        'password TEXT'
          ')');
      await db.execute('CREATE TABLE nots('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'details TEXT,'
          'user_id INTEGER,'
          'FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE CASCADE'
          ')');
      },
      onUpgrade: (Database db,int oldversion, int newversion){},
      onDowngrade: (Database db,int oldversion, int newversion){},
    );
  }
}