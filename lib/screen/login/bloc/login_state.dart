import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/user.dart';

class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLogin extends LoginState {
  InitialLogin() : super();
  @override
  toString() => 'InitialLogin';
}

class Authenticated extends LoginState {
  final User user;
  Authenticated(this.user) : super([user]);

  @override
  toString() => 'Authenticated { user: $user';
}

class AuthenticatedFailue extends LoginState {
  AuthenticatedFailue() : super();

  @override
  toString() => 'AuthenticatedFailue';
}
