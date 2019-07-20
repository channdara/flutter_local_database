import 'dart:convert';

import 'package:learning_local_database/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String tokenKey = 'TOKEN';
  static final String userKey = 'USER';

  static Future saveToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
  }

  static Future saveUser(User user) async {
    var pref = await SharedPreferences.getInstance();
    var data = json.encode(user.toJson());
    await pref.setString(userKey, data);
  }

  static Future<String> loadToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey);
  }

  static Future<User> loadUser() async {
    var pref = await SharedPreferences.getInstance();
    var data = json.decode(pref.getString(userKey));
    return User.fromJson(data);
  }

  static Future removeTokenAndUser() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove(userKey);
    await pref.remove(tokenKey);
  }
}
