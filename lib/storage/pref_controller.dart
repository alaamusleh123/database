import 'package:shared_preferences/shared_preferences.dart';
import 'package:v12_database/models/user.dart';

enum PrefKeys{
  id,name,email,LoggedIn
}
class PrefController{
  late SharedPreferences _sharedPreferences;
  static final PrefController _instance= PrefController._();
  PrefController._();
  factory PrefController(){
    return _instance;
  }
  Future<void> initPref() async{
    _sharedPreferences =await SharedPreferences.getInstance();
  }
  Future<void> save(User user) async{
    await _sharedPreferences.setBool(PrefKeys.LoggedIn.toString(), true);
    await _sharedPreferences.setInt(PrefKeys.id.toString(), user.id);
    await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
    await _sharedPreferences.setString(PrefKeys.email.toString(), user.email);
  }
  bool get loggedIn=> _sharedPreferences.getBool(PrefKeys.LoggedIn.toString())??false;

  Future<bool> clear() async=> await _sharedPreferences.clear();
  T? getValueFor<T>({required String key}){
    return _sharedPreferences.get(key) as T?;
  }
}