import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/add_transaction_event.dart';

class WalletPicking extends StatelessWidget {
  final AddTransactionBloc _addTransactionBloc;
  final Wallet _walletPicked;

  WalletPicking(
      {Key key,
      @required AddTransactionBloc addTransactionBloc,
      @required Wallet walletPicked})
      : this._addTransactionBloc = addTransactionBloc,
        this._walletPicked = walletPicked,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn ví'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.backspace),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Thêm ví'),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
        child: StreamBuilder(
            stream: _addTransactionBloc.wallets,
            builder: (context, AsyncSnapshot<List<Wallet>> snapshot) {
              if (!snapshot.hasData) return Container();
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    elevation: 15.0,
                    child: ListTile(
                      onTap: () {
                        _addTransactionBloc.dispatch(
                            ChooseWallet(wallet: snapshot.data[index]));

                        Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text(snapshot.data[index].name),
                      trailing: snapshot.data[index] == _walletPicked
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : null,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
