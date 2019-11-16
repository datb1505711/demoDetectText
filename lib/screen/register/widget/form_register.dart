import 'package:flutter/material.dart';
import 'package:love_moneyyy/screen/register/bloc/bloc.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/widget.dart';

class FormRegister extends StatefulWidget {
  final RegisterBloc _registerBloc;

  FormRegister({Key key, RegisterBloc registerBloc})
      : _registerBloc = registerBloc,
        super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          /// Title's App
          _labelRegister(),

          /// Username field
          _usernameField(),

          /// Password field
          _passwordField(),

          /// Name field
          _nameField(),

          /// Email field
          _emailField(),

          /// Gender field
          _genderField(),

          /// Phone number field
          _phoneNumberField(),

          /// Register button
          _registerButton(),

          /// Login link
          _navigateToLogin()
        ],
      ),
    );
  }

  Widget _labelRegister() {
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

  Widget _usernameField() {
    return StreamBuilder(
        stream: widget._registerBloc.username,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              style: Styles.text_field_style,
              onTap: () => widget._registerBloc
                  .onUsernameChanged(_usernameController.text),
              onChanged: widget._registerBloc.onUsernameChanged,
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

  Widget _passwordField() {
    return StreamBuilder(
        stream: widget._registerBloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: Styles.text_field_style,
                onTap: () {
                  return widget._registerBloc
                      .onPasswordChanged(_passwordController.text);
                },
                onChanged: widget._registerBloc.onPasswordChanged,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: 'Password',
                    errorText: snapshot.error),
              ));
        });
  }

  Widget _genderField() {
    return StreamBuilder(
        stream: widget._registerBloc.gender,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            width: double.maxFinite,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? Constants.genders[0],
                  onChanged: (value) {
                    widget._registerBloc.dispatch(OnGenderChanged(value));
                  },
                  items: Constants.genders.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          child: Text(
                            value,
                            style: Styles.text_field_style
                                .copyWith(color: Colors.grey[600]),
                          )),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }

  Widget _nameField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: StreamBuilder(
          stream: widget._registerBloc.name,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              style: Styles.text_field_style,
              onTap: () =>
                  widget._registerBloc.onNameChanged(_nameController.text),
              onChanged: widget._registerBloc.onNameChanged,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Enter your name',
                  errorText: snapshot.error),
            );
          }),
    );
  }

  Widget _emailField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: StreamBuilder(
          stream: widget._registerBloc.email,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              style: Styles.text_field_style,
              onTap: () =>
                  widget._registerBloc.onEmailChanged(_emailController.text),
              onChanged: widget._registerBloc.onEmailChanged,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Email',
                  errorText: snapshot.error),
            );
          }),
    );
  }

  Widget _phoneNumberField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: StreamBuilder(
          stream: widget._registerBloc.phoneNumber,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.text,
              style: Styles.text_field_style,
              onTap: () => widget._registerBloc
                  .onPhoneChanged(_phoneNumberController.text),
              onChanged: widget._registerBloc.onPhoneChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Your phone number',
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  Widget _registerButton() {
    return StreamBuilder(
        stream: widget._registerBloc.register,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return BounceInAnimation(
            duration: Duration(seconds: 3),
            child: CirleButton(
              color: snapshot.data == false ? Colors.grey : null,
              onPressed: () => snapshot.data
                  ? widget._registerBloc.dispatch(SubmitRegister())
                  : {},
              title: 'REGISTER',
            ),
          );
        });
  }

  Widget _navigateToLogin() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Do you have Account? "),
            Text(" Login", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
