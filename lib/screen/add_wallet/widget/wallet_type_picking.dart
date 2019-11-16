import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/add_wallet/bloc/bloc.dart';

class WalletTypePicking extends StatelessWidget {
  final AddWalletBloc _addWalletBloc;
  final WalletType _walletType;

  WalletTypePicking(
      {Key key,
      @required AddWalletBloc addWalletBloc,
      @required WalletType walletType})
      : this._addWalletBloc = addWalletBloc,
        this._walletType = walletType,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Loại tài khoản',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.backspace, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: _addWalletBloc.walletsType,
        builder: (context, AsyncSnapshot<List<WalletType>> snapshot) {
          if (!snapshot.hasData) return Container();

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.adjust),
                  title: Text(snapshot.data[index].description),
                  trailing: snapshot.data[index] == _walletType
                      ? Icon(Icons.check)
                      : null,
                  onTap: () {
                    _addWalletBloc
                        .dispatch(ChooseTypeWallet(snapshot.data[index]));

                    Navigator.of(context).pop();
                  },
                );
              });
        },
      ),
    );
  }
}
