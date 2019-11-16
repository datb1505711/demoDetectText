import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/add_wallet/bloc/add_wallet_bloc.dart';
import 'package:love_moneyyy/screen/add_wallet/bloc/bloc.dart';
import 'package:love_moneyyy/screen/add_wallet/widget/wallet_type_picking.dart';
import 'package:love_moneyyy/screen/add_wallet/widget/wallet_unit_picking.dart';
import 'package:love_moneyyy/widget/widget.dart';

class AddWalletForm extends StatefulWidget {
  final AddWalletBloc _addWalletBloc;

  AddWalletForm({Key key, @required AddWalletBloc addWalletBloc})
      : this._addWalletBloc = addWalletBloc;

  AddWalletFormState createState() => AddWalletFormState();
}

class AddWalletFormState extends State<AddWalletForm> {
  TextEditingController _walletMoneyController = new TextEditingController();
  TextEditingController _walletNameController = new TextEditingController();
  TextEditingController _walletGroupController = new TextEditingController();
  TextEditingController _walletUnitController = new TextEditingController();
  TextEditingController _walletNoteController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              child: Text('Số dư ban đầu'),
            ),

            ///
            _walletBalanceField(),

            Container(
              height: 20,
              color: Colors.grey[200],
            ),

            ///
            _walletNameField(),
            SizedBox(height: 10),

            ///
            _walletTypeField(),
            SizedBox(height: 10),

            ///
            _unitMoney(),

            ///
            _walletNoteField(),
            SizedBox(height: 10),

            ///
            _walletSaveButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _walletNameField() {
    return StreamBuilder(
        stream: widget._addWalletBloc.name,
        builder: (context, snapshot) {
          return ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.grey,
              size: 30,
            ),
            title: TextField(
              controller: _walletNameController,
              onChanged: (text) {
                widget._addWalletBloc.onNameChanged(text);
              },
              onTap: () {
                widget._addWalletBloc.onNameChanged(_walletNameController.text);
              },
              decoration: InputDecoration(
                hintText: 'Tên tài khoản',
                errorText: snapshot.error,
              ),
              style: TextStyle(fontSize: 20),
            ),
          );
        });
    //
  }

  Widget _walletTypeField() {
    return StreamBuilder(
        stream: widget._addWalletBloc.walletType,
        builder: (context, AsyncSnapshot<WalletType> snapshot) {
          if (!snapshot.hasData) return Container();
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => new WalletTypePicking(
                    addWalletBloc: widget._addWalletBloc,
                    walletType: snapshot.data,
                  ),
                ),
              );
            },
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.grey,
              size: 30,
            ),
            title: TextField(
              controller: _walletGroupController,
              decoration: InputDecoration(
                  enabled: false,
                  hintText: snapshot.data.description,
                  suffixIcon: Icon(Icons.arrow_forward_ios)),
              style: TextStyle(fontSize: 20),
            ),
          );
        });
  }

  Widget _walletBalanceField() {
    return StreamBuilder(
        stream: widget._addWalletBloc.total,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            alignment: Alignment.topLeft,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _walletMoneyController,
              onTap: () {
                widget._addWalletBloc.onTotalChanged(
                    _walletMoneyController.text == ''
                        ? 0.toString()
                        : _walletMoneyController.text);
              },
              onChanged: (text) {
                widget._addWalletBloc.onTotalChanged(text);
              },
              decoration: InputDecoration(
                hintText: '0',
                errorText: snapshot.error,
                suffixIcon: Icon(Icons.monetization_on),
              ),
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.right,
            ),
          );
        });
  }

  Widget _unitMoney() {
    return StreamBuilder(
        stream: widget._addWalletBloc.walletUnitMoney,
        builder: (context, AsyncSnapshot<WalletUnitMoney> snapshot) {
          if (!snapshot.hasData) return Container();
          return ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.grey,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WalletUnitMoneyPicking(
                      addWalletBloc: widget._addWalletBloc)));
            },
            title: TextField(
              controller: _walletUnitController,
              decoration: InputDecoration(
                  enabled: false,
                  hintText: snapshot.data.description,
                  suffixIcon: Icon(Icons.arrow_forward_ios)),
              style: TextStyle(fontSize: 20),
            ),
          );
        });
  }

  Widget _walletNoteField() {
    return StreamBuilder(
        stream: widget._addWalletBloc.note,
        builder: (context, snapshot) {
          return ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.grey,
              size: 30,
            ),
            title: TextField(
              onTap: () {
                widget._addWalletBloc.onNoteChanged(_walletNoteController.text);
              },
              onChanged: (text) {
                widget._addWalletBloc.onNoteChanged(text);
              },
              controller: _walletNoteController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                hintText: 'Note',
              ),
              style: TextStyle(fontSize: 20),
            ),
          );
        });
  }

  Widget _walletSaveButton() {
    return StreamBuilder(
        stream: widget._addWalletBloc.enableSaving,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return BounceInAnimation(
            duration: Duration(seconds: 3),
            child: RaisedButton(
              onPressed: () => snapshot.data == true
                  ? widget._addWalletBloc.dispatch(SubmitCreate())
                  : {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(96, 16, 96, 16),
                child: Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: snapshot.data == true
                  ? Color.fromRGBO(0, 122, 255, 1)
                  : Colors.grey,
            ),
          );
        });
  }
}
