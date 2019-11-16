import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/util/util.dart';

import 'package:rxdart/rxdart.dart';

class TransactionProvider {
  Subject<List<TransactionType>> getAllTransactionType() {
    BehaviorSubject<List<TransactionType>> _transactionTypesSubject =
        new BehaviorSubject();

    var response =
        cloud.Firestore.instance.collection('transaction_group').getDocuments();

    List<TransactionType> _transactionTypes = [];

    response.then((ds) {
      ds.documents.forEach((snapshot) {
        var transactionType = TransactionType.fromJSON(snapshot.data);
        _transactionTypes.add(transactionType);
      });

      _transactionTypes = Sort.sortListTransactionType(_transactionTypes);
      _transactionTypesSubject.add(_transactionTypes);
    }, onError: (error) {
      _transactionTypesSubject.addError(error);
    }).whenComplete(() {
      _transactionTypesSubject?.close();
    });

    return _transactionTypesSubject;
  }

  Subject<Transaction> createTransaction({@required Transaction transaction}) {
    BehaviorSubject<Transaction> _transactionSubject = new BehaviorSubject();

    var data = transaction.toJSON();

    cloud.Firestore.instance.collection("transaction").document().setData(data);

    _transactionSubject.add(transaction);
    return _transactionSubject;
  }

  Subject<List<Transaction>> getAllTransaction() {
    BehaviorSubject<List<Transaction>> _transactionSubject =
        new BehaviorSubject();

    List<Transaction> _transactions = [];

    var response =
        cloud.Firestore.instance.collection("transaction").getDocuments();
    response.then((document) {
      if (document.documents.isNotEmpty) {
        document.documents.forEach((snapshot) {
          _transactions.add(Transaction.fromJSON(snapshot.data));
        });
        _transactionSubject.add(_transactions);
      }
    }, onError: (e) {
      _transactionSubject.addError(e);
    }).whenComplete(() {
      _transactionSubject?.close();
    });

    return _transactionSubject;
  }
}
