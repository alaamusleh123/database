import 'package:flutter/cupertino.dart';
import 'package:v12_database/controller/user_db_controller.dart';
import 'package:v12_database/models/user.dart';

class UserProvider extends ChangeNotifier{
  final UserDbController _dbControlle= UserDbController();

  Future<bool> login({required String email, required String password}) async{
    return await _dbControlle.login(email: email, password: password);
  }

  Future<bool> creat(User user) async{
    int newRowId= await _dbControlle.creat(user);
    return newRowId !=0;
  }

  Future<bool> update(User user) async{
    return await _dbControlle.update(user);
  }

  Future<bool> delete(int id) async{
    return await _dbControlle.delete(id);
  }
}