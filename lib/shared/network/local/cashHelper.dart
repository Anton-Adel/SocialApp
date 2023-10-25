import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static SharedPreferences? sharedPreferences;

  static init() async {

    sharedPreferences=await SharedPreferences.getInstance();
  }

 static Future<bool>  PutBoolean (String key,bool value) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool?  getBoolean (String key)  {
    return  sharedPreferences!.getBool(key);
  }

  static dynamic  getData (String key)  {
    return  sharedPreferences!.get(key);
  }

  static Future<bool> SetData ({
  required String key,
    required dynamic value
}) async
  {
    if(value is String) return await sharedPreferences!.setString(key, value) ;
    if(value is int) return await sharedPreferences!.setInt(key, value) ;
    if(value is bool) return await sharedPreferences!.setBool(key, value) ;
    else
      return await sharedPreferences!.setDouble(key, value) ;

  }


  static Future<bool> RemoveItem({
  required String key
})async{
    return await sharedPreferences!.remove(key);
  }

}