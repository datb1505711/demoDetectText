import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/model.dart';

class Preferences {
  static const String user_key = 'user';

  /// add `User` Preferences
  static Future<bool> addUser(User user) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    /// convert `Object` [user] to `String` [_user].
    Map<String, dynamic> _user = {
      'username': user.username,
      'password': user.password,
      'name': user.name,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'gender': user.gender,
      'access_token': user.accessToken
    };

    return _sharedPreferences.setString(user_key, jsonEncode(_user));
  }

  /// change User
  static Future<bool> changeUser(User user) async {
    return addUser(user);
  }

  /// get User
  static Future<User> getUser() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    var _user = _sharedPreferences.getString(user_key);

    /// if [_user] is not empty, convert `String` [_user] to `User` [_userJson]
    if (_user != null) {
      var _userJson = jsonDecode(_user);
      return User.fromJSON(_userJson);
    }
    return null;
  }

  /// remove User preferences
  static Future<bool> removeUser() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    return _sharedPreferences.remove(user_key);
  }
}
