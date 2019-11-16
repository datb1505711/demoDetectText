import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/model.dart';

class UserState extends Equatable {
  final User user;
  UserState(this.user, [List props = const []]) : super(props);

  @override
  toString() => 'UserState';
}

class InitUserState extends UserState {
  InitUserState(User user) : super(user);

  @override
  toString() => 'InitUserState';
}

class AuthenticatedUserState extends UserState {
  AuthenticatedUserState(User user) : super(user);

  @override
  toString() => 'AuthenticatedUserState ';
}

class AuthenticationFailUserState extends UserState {
  AuthenticationFailUserState(User user) : super(user);

  @override
  toString() => 'AuthenticationFailUserState';
}
