import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';

class UserAction extends Equatable {
  UserAction([List props = const []]) : super(props);
}

class AddUser extends UserAction {
  final User user;

  AddUser({@required this.user}) : super([user]);

  @override
  toString() => 'AddUser {user: $user}';
}

class ChangeUser extends UserAction {
  final User user;

  ChangeUser({@required this.user}) : super([user]);

  @override
  toString() => 'ChangeUser {user: $user}';
}

class RemoveUser extends UserAction {
  RemoveUser() : super();

  @override
  toString() => 'RemoveUser';
}
