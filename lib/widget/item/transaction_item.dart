import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/util/util.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({Key key, @required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          //
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  transaction.createAt != null
                      ? Constants.getDayOfWeek
                          .format(transaction.createAt)
                          .toString()
                      : " ",
                  style: TextStyle(fontSize: 13, color: Colors.red),
                ),
                Text(
                  transaction.createAt != null
                      ? Constants.getDay.format(transaction.createAt).toString()
                      : " ",
                  style: TextStyle(fontSize: 32),
                )
              ],
            ),
          ),

          //
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    'Type: ${transaction.transactionType}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),

          ///
          Container(
            child: Text(
              '-${Converters.convertCurrency(transaction.total)} vnd',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),

          //
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
