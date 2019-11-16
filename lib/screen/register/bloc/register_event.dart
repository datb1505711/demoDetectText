import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  RegisterEvent({List props = const []}) : super([props]);
}

class InitData extends RegisterEvent {
  InitData() : super();

  @override
  toString() => 'InitData';
}

class OnGenderChanged extends RegisterEvent {
  final String gender;
  OnGenderChanged(this.gender) : super();

  @override
  toString() => 'OnGenderChanged';
}

class SubmitRegister extends RegisterEvent {
  // final String username;
  // final String password;
  // final String name;
  // final String email;
  // final String gender;
  // final String phoneNumber;

  // OnSubmit(
  //     {this.username,
  //     this.password,
  //     this.name,
  //     this.email,
  //     this.gender,
  //     this.phoneNumber})
  //     : super();

  // @override
  // toString() =>
  //     'OnSubmit { username: $username, password: $password, name: $name, email: $email, gender: $gender, phoneNumber: $phoneNumber}';

  SubmitRegister() : super();

  @override
  toString() => 'OnSubmit';
}
