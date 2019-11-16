import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/util/preferences.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/model.dart';
import '../../../providers/user_providers.dart';
import '../../../repositorys/user_repositories.dart';
import '../../../util/util.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository =
      new UserRepository(userProvider: new UserProvider());

  final BehaviorSubject<List<String>> _messagesController =
      new BehaviorSubject();
  final BehaviorSubject<bool> _rememberMeController = new BehaviorSubject();
  final BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  final BehaviorSubject<String> _usernameController = new BehaviorSubject();
  final BehaviorSubject<String> _passwordController = new BehaviorSubject();
  final BehaviorSubject<bool> _loginController = new BehaviorSubject();
  bool _validUsername = false, _validPassword = false;
  User _user;

  Stream<List<String>> get messages => _messagesController.stream;
  Stream<bool> get rememberMe => _rememberMeController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<bool> get login => _loginController.stream;

  Function(bool) get onRememberChanged => _rememberMeController.add;
  Function(String) get onUsernameChanged => _usernameController.add;
  Function(String) get onPasswordChanged => _passwordController.add;

  @override
  LoginState get initialState {
    _rememberMeController.add(false);
    _loadingController.add(false);
    _loginController.add(true);

    Preferences.getUser().then((user) {
      if (user != null) {
        _user = user;
        dispatch(
            SubmitLogin(username: _user.username, password: _user.password));
      }
    });

    return InitialLogin();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is ToggleRememberMe) yield* _mapTogleRememberMeToState(event);
    if (event is SubmitLogin) yield* _mapSubmitLoginToState(event);
    if (event is UpdateState) yield* _mapUpdateStateToState(event);
  }

  Stream<String> get username => _usernameController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (username, sink) {
        var validResult = Validators.validateUsername(username);
        _validUsername = validResult == null;
        validResult == null ? sink.add(username) : sink.addError(validResult);

        _validateLogin();
      }));

  Stream<String> get password => _passwordController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (password, sink) {
        var validResult = Validators.validatePassword(password);
        _validPassword = validResult == null;

        validResult == null ? sink.add(password) : sink.addError(validResult);

        _validateLogin();
      }));

  Stream<LoginState> _mapInitDataToState(InitData event) async* {
    _rememberMeController.add(false);
    _loadingController.add(false);
    _loginController.add(true);
  }

  Stream<LoginState> _mapTogleRememberMeToState(ToggleRememberMe event) async* {
    _rememberMeController.add(!_rememberMeController.value);
  }

  Stream<LoginState> _mapUpdateStateToState(UpdateState event) async* {
    yield event.loginState;
  }

  Stream<LoginState> _mapSubmitLoginToState(SubmitLogin event) async* {
    _loadingController.add(true);

    /// Call api get user login
    _userRepository
        .login(username: event.username, password: event.password)
        .listen((user) {
      _user = user;

      /// Save login state
      if (_rememberMeController.value) Preferences.addUser(_user);

      dispatch(UpdateState(loginState: Authenticated(_user)));
    }, onError: (error) {
      /// show messages when login fail
      _messagesController.addError(error);
    }, onDone: () {
      /// disable loading when login done
      _loadingController.add(false);
    });

    if (_user != null) yield Authenticated(_user);
  }

  /// Validate login, if all field validate successful, set login is true, else set it false.
  void _validateLogin() {
    if (_validUsername && _validPassword)
      _loginController.add(true);
    else
      _loginController.add(false);
  }

  @override
  void dispose() {
    super.dispose();
    _messagesController?.close();
    _usernameController?.close();
    _passwordController?.close();
    _loginController?.close();
    _rememberMeController?.close();
    _loadingController?.close();
  }
}
