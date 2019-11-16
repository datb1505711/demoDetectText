import 'package:flutter/material.dart';
import 'package:love_moneyyy/screen/register/bloc/register_bloc.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/widget.dart';

import 'bloc/bloc.dart';
import 'widget/form_register.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterBloc _registerBloc = new RegisterBloc();
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  FormRegister _formRegister;

  // Save screen
  Widget _registerScreen;
  @override
  void initState() {
    super.initState();
    widget._registerBloc.dispatch(InitData());

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      widget._registerBloc.messages.listen((messages) {
        _showDialog(messages, isSuccess: true);
      }, onError: (messages) {
        _showDialog(messages);
      });
    });
    _formRegister = FormRegister(registerBloc: widget._registerBloc);
  }

  @override
  Widget build(BuildContext context) {
    if (_registerScreen == null) _registerScreen = _createForm();
    return _registerScreen;
  }

  Widget _createForm() {
    return Scaffold(
        backgroundColor: Styles.white_color,
        body: Stack(
          children: <Widget>[
            /// Register Screen
            SingleChildScrollView(
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

                  _formRegister,
                ],
              ),
            ),

            /// Loading Widget
            StreamBuilder(
                stream: widget._registerBloc.loading,
                builder: (context, snapshot) => ProgressLoading(
                    backgroundColor: Colors.transparent,
                    containerColor: Colors.transparent,
                    color: Colors.black,
                    loading: snapshot.data ?? false)),
          ],
        ));
  }

  Future _showDialog(List<String> messages, {bool isSuccess}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          MessagesDialog(messages: messages, isSuccess: isSuccess));

  @override
  void dispose() {
    super.dispose();

    widget._registerBloc?.dispose();
  }
}
