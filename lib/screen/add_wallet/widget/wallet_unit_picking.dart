import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/add_wallet/bloc/bloc.dart';

class WalletUnitMoneyPicking extends StatelessWidget {
  final AddWalletBloc _addWalletBloc;

  WalletUnitMoneyPicking({Key key, AddWalletBloc addWalletBloc})
      : this._addWalletBloc = addWalletBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Đơn vị tiền',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.backspace, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: _addWalletBloc.walletsUnitMoney,
        builder: (context, AsyncSnapshot<List<WalletUnitMoney>> snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  _addWalletBloc
                      .dispatch(ChooseUnitMoney(snapshot.data[index]));

                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.add_circle_outline),
                title: Text(snapshot.data[index].description),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        },
      ),
    );
  }
}
