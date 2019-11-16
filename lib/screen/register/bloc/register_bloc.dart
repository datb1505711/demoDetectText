import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/providers/user_providers.dart';
import 'package:love_moneyyy/repositorys/user_repositories.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepository =
      new UserRepository(userProvider: new UserProvider());

  final BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  final BehaviorSubject<List<String>> _messagesController =
      new BehaviorSubject();
  final BehaviorSubject<bool> _registerController = new BehaviorSubject();
  final BehaviorSubject<String> _usernameController = new BehaviorSubject();
  final BehaviorSubject<String> _passwordController = new BehaviorSubject();
  final BehaviorSubject<String> _nameController = new BehaviorSubject();
  final BehaviorSubject<String> _emailController = new BehaviorSubject();
  final BehaviorSubject<String> _genderController = new BehaviorSubject();
  final BehaviorSubject<String> _phoneController = new BehaviorSubject();

  bool _validUsername = false,
      _validPassword = false,
      _validName = false,
      _validEmail = false,
      _validPhoneNumber = false;

  Function(String) get onUsernameChanged => _usernameController.add;
  Function(String) get onPasswordChanged => _passwordController.add;
  Function(String) get onNameChanged => _nameController.add;
  Function(String) get onEmailChanged => _emailController.add;
  Function(String) get onPhoneChanged => _phoneController.add;

  Stream<String> get gender => _genderController.stream;
  Stream<bool> get register => _registerController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<List<String>> get messages => _messagesController.stream;

  Stream<String> get username => _usernameController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (username, sink) {
        /// Validate username
        var validResult = Validators.validateUsername(username);
        _validUsername = validResult == null;
        validResult == null ? sink.add(username) : sink.addError(validResult);

        /// When validate all field, enable button register
        _validateRegister();
      }));

  Stream<String> get password => _passwordController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (password, sink) {
        var validResult = Validators.validatePassword(password);
        _validPassword = validResult == null;

        validResult == null ? sink.add(password) : sink.addError(validResult);

        /// When validate all field, enable button register
        _validateRegister();
      }));

  Stream<String> get name => _nameController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (name, sink) {
        var validResult = Validators.validateName(name);
        _validName = validResult == null;

        validResult == null ? sink.add(name) : sink.addError(validResult);

        /// When validate all field, enable button register
        _validateRegister();
      }));

  Stream<String> get email => _emailController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (email, sink) {
        var validResult = Validators.validateEmail(email);
        _validEmail = validResult == null;

        validResult == null ? sink.add(email) : sink.addError(validResult);

        /// When validate all field, enable button register
        _validateRegister();
      }));

  Stream<String> get phoneNumber => _phoneController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (phoneNumber, sink) {
        var validResult = Validators.validatePhoneNumber(phoneNumber);
        _validPhoneNumber = validResult == null;

        validResult == null
            ? sink.add(phoneNumber)
            : sink.addError(validResult);

        /// When validate all field, enable button register
        _validateRegister();
      }));

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is SubmitRegister) yield* _mapSubmitRegisterToState(event);
    if (event is OnGenderChanged) yield* _mapOnGenderChangedToState(event);
  }

  Stream<RegisterState> _mapInitDataToState(InitData event) async* {
    _loadingController.add(false);
    _genderController.add(Constants.genders[0]);
    _registerController.add(false);
  }

  Stream<RegisterState> _mapSubmitRegisterToState(SubmitRegister event) async* {
    _loadingController.add(true);

    /* Call Firebase to create account with 
    @param email,gender,name,password,phoneNumber,username.
    */
    _userRepository
        .register(
            email: _emailController.value,
            gender: _genderController.value,
            name: _nameController.value,
            password: _passwordController.value,
            phoneNumber: _phoneController.value,
            username: _usernameController.value)
        .listen((message) {
      _messagesController.add(message);
    }, onError: (error) {
      /// When register fail, show error messages
      _messagesController.addError(error);
    }, onDone: () {
      /// When done, set Loading is false
      _loadingController.add(false);
    });
  }

  Stream<RegisterState> _mapOnGenderChangedToState(
      OnGenderChanged event) async* {
    _genderController.add(event.gender);
  }

  /// Function to validate register, if all field validate success, set register is true, else set it false.
  void _validateRegister() {
    if (_validUsername &&
        _validPassword &&
        _validEmail &&
        _validName &&
        _validPhoneNumber)
      _registerController.add(true);
    else
      _registerController.add(false);
  }

  @override
  void dispose() {
    super.dispose();
    _loadingController?.close();
    _messagesController.close();
    _registerController.close();
    _usernameController.close();
    _passwordController.close();
    _nameController.close();
    _emailController.close();
    _genderController.close();
    _phoneController.close();
  }
}
