import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:rxdart/rxdart.dart';

import 'base_authentication.dart';

class UserProvider {
  Authentication auth = new Auth();
  Subject<User> login({@required String username, @required String password}) {
    /// Define Stream [user] to store user data when login,
    BehaviorSubject<User> userSubject = new BehaviorSubject();

    var response =
        Firestore.instance.collection('users').document(username).snapshots();
    Future<void> handleDataResponse(DocumentSnapshot user) async {
      if (!(user.data == null)) {
        User _user = User.fromJSON(user.data);
        if (_user != null) {
          signIn(_user.email, password);
          userSubject.add(_user);
        } else
          userSubject.addError([Messages.login_fail]);
      } else
        userSubject.addError([Messages.login_fail]);
    }

    response.listen((user) {
      handleDataResponse(user).then((val) {
        userSubject?.close();
      });
    });

    return userSubject;
  }

  Subject<List<String>> register({
    @required String username,
    @required String password,
    @required String name,
    @required String email,
    @required String phoneNumber,
    @required String gender,
  }) {
    BehaviorSubject<List<String>> userSubject = new BehaviorSubject();

    var dataUser = {
      "username": username,
      "password": password,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "gender": gender,
    };

    /// [List<User>] to get all data Users in DB.
    List<User> _users = [];

    bool _existUser = false;

    var response = Firestore.instance.collection('users').getDocuments();
    response.then((value) {
      /// If [value] is empty, create new account
      if (value.documents.isEmpty) {
        createAccount(
            email: email,
            password: password,
            dataUser: dataUser,
            username: username);
      }

      /// if [value] is not empty. check [username] & [email] is exist in DB.
      else {
        value.documents.forEach((data) {
          /// get all username and email in DB
          if (data.data.isNotEmpty) {
            _users.add(User.fromJSON(data.data));
          }
        });

        /// If [username] &  [email ] is exits in DB, show messages error.
        _users.forEach((user) {
          if (user.username == username || user.email == email) {
            userSubject.addError([Messages.register_fail]);
            _existUser = true;
          }
        });
        if (!_existUser) {
          createAccount(
              email: email,
              password: password,
              dataUser: dataUser,
              username: username);
          userSubject.add([Messages.register_successful]);
        }
      }
    }).whenComplete(() {
      userSubject?.close();
    });

    return userSubject;
  }

  // create an Account
  void createAccount({email, password, username, dataUser}) async {
    signUp(email, password);
    signIn(email, password);
    await getAccessToken().then((token) {
      dataUser['access_token'] = token;
    });

    Firestore.instance
        .collection('users')
        .document(username)
        .setData(dataUser)
        .then((val) {
      signOut();
    });
  }

  // sign in firebase authentication
  void signIn(email, password) async {
    await auth.signIn(email, password);
  }

  // sign in firebase authentication
  void signUp(email, password) async {
    await auth.signUp(email, password);
  }

  // sign in firebase authentication
  Future signOut() async {
    await auth.signOut();
  }

  // sign in firebase authentication
  Future<String> getAccessToken() async {
    return await auth.getAccessToken();
  }

  Subject<bool> logout() {
    BehaviorSubject<bool> _logout = new BehaviorSubject();

    signOut().then((_) {
      _logout.add(true);
    }).catchError((e) {
      _logout.add(false);
    });
    return _logout;
  }
}
