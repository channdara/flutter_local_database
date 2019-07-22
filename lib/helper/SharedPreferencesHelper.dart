import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String tokenKey = 'TOKEN';
  static final String userKey = 'USER';

  static Future saveToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
  }

  static Future saveUserID(int id) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt(userKey, id);
  }

  static Future<String> loadToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey);
  }

  static Future<int> loadUserID() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getInt(userKey);
  }

  static Future removeTokenAndUser() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove(tokenKey);
    await pref.remove(userKey);
  }
}
