import 'package:sqflite/sqflite.dart';
import 'package:v12_database/database/db_controller.dart';
import 'package:v12_database/database/db_operations.dart';
import 'package:v12_database/models/user.dart';
import 'package:v12_database/storage/pref_controller.dart';

class UserDbController implements DbOperations<User>{
  Database database=DbController().database;

  Future<bool> login({required String email, required String password}) async{
    List<Map<String,dynamic>> maps=
    await database.query('users',where: 'email=? AND password=?',whereArgs:[email,password] );
    if(maps.isNotEmpty){
      User user= User.fromMap(maps.first);
      await PrefController().save(user);
    }
    return maps.isNotEmpty;
  }

  @override
  Future<int> creat(User modle) async{
    int newRowId= await database.insert('users', modle.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async{
   int countOfDeletedRow= await database.delete('users', where: 'id=?',whereArgs: [id]);
   return countOfDeletedRow==1;
  }

  @override
  Future<List<User>> read() async{
    List<Map<String,dynamic>> rows= await database.query('users');
    return rows.map((Map<String,dynamic> rowMap) => User.fromMap(rowMap)).toList();
  }

  @override
  Future<User?> show(int id) async{
    List<Map<String,dynamic>> rows= await database.query('users',where: 'id=?',whereArgs: [id]);
    if(rows.isNotEmpty){
      return User.fromMap(rows.first);
    }
  }

  @override
  Future<bool> update(User model) async{
    int countOfUpdatedRows=
    await database.update('users', model.toMap(),where: 'id=?',whereArgs: [model.id]);
    return countOfUpdatedRows==1;
  }

}