import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/add_wallet/widget/add_wallet_form.dart';
import 'package:love_moneyyy/widget/progress_indicators.dart';
import 'package:love_moneyyy/widget/widget.dart';

import 'bloc/bloc.dart';

class AddWalletScreen extends StatefulWidget {
  final AddWalletBloc _addWalletBloc = new AddWalletBloc();
  @override
  AddWalletScreenState createState() => AddWalletScreenState();
}

class AddWalletScreenState extends State<AddWalletScreen> {
  AddWalletForm _addWalletForm;
  var _body;
  @override
  void initState() {
    super.initState();
    _addWalletForm = new AddWalletForm(
      addWalletBloc: widget._addWalletBloc,
    );

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      var user = StoreProvider.of<UserState>(context).state.user;

      widget._addWalletBloc.dispatch(InitData(user));
    });

    widget._addWalletBloc.messages.listen((messages) {
      _showDialog(messages, isSuccess: true).then((val) {
        Navigator.of(context).pop();
      });
    }, onError: (error) {
      _showDialog(error);
    });

    _body = Stack(
      children: <Widget>[
        _addWalletForm,

        ///Loading
        StreamBuilder(
          stream: widget._addWalletBloc.loading,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return ProgressLoading(
                backgroundColor: Colors.transparent,
                containerColor: Colors.transparent,
                color: Colors.black,
                loading: snapshot.data ?? false);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tạo ví mới',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: _body,
    );
  }

  Future _showDialog(List<String> messages, {bool isSuccess}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          MessagesDialog(messages: messages, isSuccess: isSuccess));
}
