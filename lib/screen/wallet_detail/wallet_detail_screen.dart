import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/wallet_detail/bloc/wallet_detail_bloc.dart';
import 'package:love_moneyyy/widget/item/transaction_item.dart';

import 'bloc/bloc.dart';

class WalletDetail extends StatelessWidget {
  final WalletDetailBloc _walletDetailBloc = new WalletDetailBloc();

  final TextStyle _style = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    _walletDetailBloc
        .dispatch(InitData(StoreProvider.of<UserState>(context).state.user));

    _walletDetailBloc.dispatch(GetAllTransaction());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet Detail",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ///
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              width: double.maxFinite,
              child: Text(
                "Tổng quan",
                style: TextStyle(fontSize: 26),
              ),
            ),

            ///
            _buildSumMoneyIn(),

            ///
            _buildSumMoneyOut(),

            ///
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              width: double.maxFinite,
              child: Text(
                "Chi tiết",
                style: TextStyle(fontSize: 18),
              ),
            ),

            ///
            _buildTransaction(),

            ///
            _buildMoneyTotal(),
          ],
        ),
      ),
    );
  }

  _buildSumMoneyIn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tổng thu: ",
              style: _style,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "2.000.000vnd",
              style: _style,
            ),
          ),
        ),
      ],
    );
  }

  _buildSumMoneyOut() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tổng chi: ",
              style: _style,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "2.000.000vnd",
              style: _style,
            ),
          ),
        ),
      ],
    );
  }

  _buildMoneyTotal() {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tổng cộng: ",
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "5.000.000vnd",
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTransaction() {
    return Expanded(
      child: StreamBuilder(
          stream: _walletDetailBloc.transactions,
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            if (!snapshot.hasData) return Container();

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: snapshot.data[index]
                    // new Transaction(
                    //     createAt: DateTime.now(),
                    //     event: "",
                    //     id: "1",
                    //     imageURL: "",
                    //     name: "",
                    //     place: "",
                    //     total: "111",
                    //     transactionType: "sad",
                    //     trip: "212",
                    //     walletId: '11'),
                    );
              },
            );
          }),
    );
  }
}
