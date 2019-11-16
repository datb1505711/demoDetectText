import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/redux/actions/actions.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/login/widget/login_form.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/widget.dart';
import 'bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  final LoginBloc _loginBloc = new LoginBloc();
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginForm _loginForm;

  // Save Form
  Widget _loginScreen;
  @override
  void initState() {
    super.initState();
    _loginForm = LoginForm(loginBloc: widget._loginBloc);

    // WidgetsBinding.instance.addPostFrameCallback((duration) {});

    widget._loginBloc.messages.listen((messages) {
      _showDialog(messages, isSuccess: true);
    }, onError: (messages) {
      _showDialog(messages);
    });

    widget._loginBloc.dispatch(InitData());
  }

  @override
  Widget build(BuildContext context) {
    if (_loginScreen == null) _loginScreen = _createForm();

    return _loginScreen;
  }

  Widget _createForm() {
    return StoreBuilder<UserState>(onDidChange: (store) {
      if (store.state is AuthenticatedUserState)
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RoutesURL.main_screen, (route) => false);
    }, builder: (context, store) {
      return Stack(
        children: <Widget>[
          BlocListener(
            bloc: widget._loginBloc,
            listener: (context, state) {
              if (state is Authenticated)
                store.dispatch(AddUser(user: state.user));
            },
            child: Container(),
          ),

          ///Login Screen
          Scaffold(
            backgroundColor: Styles.white_color,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    /// Logo App
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Image.asset(
                        Constants.app_logo,
                        fit: BoxFit.fill,
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),

                    _loginForm
                  ],
                ),
              ),
            ),
          ),

          /// Progress Loading
          StreamBuilder(
            stream: widget._loginBloc.loading,
            builder: (context, snapshot) => ProgressLoading(
                backgroundColor: Colors.transparent,
                containerColor: Colors.transparent,
                color: Colors.black,
                loading: snapshot.data ?? false),
          ),
        ],
      );
    });
  }

  Future _showDialog(List<String> messages, {bool isSuccess}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          MessagesDialog(messages: messages, isSuccess: isSuccess));

  @override
  void dispose() {
    super.dispose();

    widget._loginBloc?.dispose();
  }
}
