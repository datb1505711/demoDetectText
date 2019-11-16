import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  RegisterState({List props = const []}) : super([props]);
}

class RegisterInitial extends RegisterState {
  RegisterInitial();

  @override
  toString() => 'RegisterInitial';
}

class Registing extends RegisterState {
  Registing();

  @override
  toString() => 'Registing';
}

class Registed extends RegisterState {
  Registed();

  @override
  toString() => 'Registed';
}

class RegistFail extends RegisterState {
  RegistFail();

  @override
  toString() => 'RegistFail';
}
