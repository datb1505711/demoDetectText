import 'package:flutter/material.dart';
import 'package:love_moneyyy/screen/login/bloc/bloc.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/widget.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc _loginBloc;

  /// Constructor
  LoginForm({Key key, @required LoginBloc loginBloc})
      : _loginBloc = loginBloc,
        super(key: key);
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Widget _loginForm;
  @override
  Widget build(BuildContext context) {
    if (_loginForm == null) _loginForm = _createLoginForm();
    return _loginForm;
  }

  Widget _createLoginForm() {
    return Container(
      child: Column(
        children: <Widget>[
          /// Title's app label
          _labelLogin(),

          /// Username field
          _usernameField(),

          /// Password field
          _passwordField(),

          /// Remember login checkbox
          _rememberMeCheckbox(),

          /// Login Button
          _loginButton(),

          SizedBox(
            height: 20.0,
          ),

          /// Create account link
          _navigateToSignIn(),
        ],
      ),
    );
  }

  Widget _labelLogin() {
    return Center(
      child: Text(
        'Love Money',
        style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _navigateToSignIn() {
    return Container(
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesURL.register_screen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You haven't account,"),
            Text(" Sign up", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _rememberMeCheckbox() {
    return StreamBuilder(
        stream: widget._loginBloc.rememberMe,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () =>
                widget._loginBloc.onRememberChanged(!snapshot.data ?? false),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    onChanged: widget._loginBloc.onRememberChanged,
                    value: snapshot.data ?? false,
                  ),
                  Text('Remember me'),
                ],
              ),
            ),
          );
        });
  }

  Widget _loginButton() {
    return StreamBuilder(
        stream: widget._loginBloc.login,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return BounceInAnimation(
            duration: Duration(seconds: 3),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5)),
              onPressed: () => widget._loginBloc.dispatch(
                  SubmitLogin(username: 'thanhdat1', password: 'thanhdat')),
              child: Container(
                padding: const EdgeInsets.fromLTRB(96, 16, 96, 16),
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color:
                  snapshot.data ? Color.fromRGBO(0, 122, 255, 1) : Colors.grey,
            ),
          );
        });
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: StreamBuilder(
          stream: widget._loginBloc.password,
          builder: (context, snapshot) {
            return TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              onTap: () =>
                  widget._loginBloc.onPasswordChanged(_passwordController.text),
              onChanged: widget._loginBloc.onPasswordChanged,
              style: Styles.text_field_style,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Password',
                  errorText: snapshot.error),
            );
          }),
    );
  }

  Widget _usernameField() {
    return StreamBuilder(
        stream: widget._loginBloc.username,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              style: Styles.text_field_style,
              onTap: () =>
                  widget._loginBloc.onUsernameChanged(_usernameController.text),
              onChanged: widget._loginBloc.onUsernameChanged,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Username',
                  errorText: snapshot.error),
            ),
          );
        });
  }
}
