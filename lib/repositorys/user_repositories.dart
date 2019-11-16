import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/user_providers.dart';
import 'package:rxdart/subjects.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository({@required UserProvider userProvider})
      : _userProvider = userProvider,
        super();

  // /User login
  Subject<User> login({@required String username, @required String password}) =>
      _userProvider.login(username: username, password: password);

  ///User register
  Subject<List<String>> register({
    @required String username,
    @required String password,
    @required String name,
    @required String gender,
    @required String email,
    @required String phoneNumber,
  }) =>
      _userProvider.register(
        username: username,
        password: password,
        name: name,
        gender: gender,
        email: email,
        phoneNumber: phoneNumber,
      );

  /// User logout
  Subject<bool> logout() => _userProvider.logout();
}
