import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';

class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class ToggleRememberMe extends LoginEvent {
  ToggleRememberMe() : super();

  @override
  toString() => 'ToggleRememberMe';
}

class InitData extends LoginEvent {
  InitData() : super();

  @override
  toString() => 'InitData';
}

class UpdateState extends LoginEvent {
  final LoginState loginState;
  UpdateState({this.loginState}) : super();

  @override
  toString() => 'UpdateState';
}

class SubmitLogin extends LoginEvent {
  final String username;
  final String password;

  SubmitLogin({@required this.username, @required this.password}) : super();

  @override
  toString() => 'SubmitLogin';
}
