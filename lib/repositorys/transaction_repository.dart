import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/provider.dart';
import 'package:rxdart/rxdart.dart';

class TransactionRepository {
  TransactionProvider _transactionProvider = new TransactionProvider();
  WalletProvider _walletProvider = new WalletProvider();

  Subject<List<TransactionType>> getAllTransactionType() {
    return _transactionProvider.getAllTransactionType();
  }

  Subject<Transaction> createTransaction({@required Transaction transaction}) {
    return _transactionProvider.createTransaction(transaction: transaction);
  }

  Subject<List<Transaction>> getAllTransaction({@required String username}) {
    BehaviorSubject<List<Transaction>> _transactionsController =
        new BehaviorSubject();

    List<String> _walletOfUsername = [];
    List<Transaction> _transactions = [];

    _walletProvider.getAllWallet(username: username).listen((wallets) {
      wallets.forEach((wallet) {
        _walletOfUsername.add(wallet.id);
      });
    });

    _transactionProvider.getAllTransaction().listen((list) {
      list.forEach((transaction) {
        if (_walletOfUsername.contains(transaction.walletId)) {
          _transactions.add(transaction);
        }
      });

      _transactionsController.add(_transactions);
    });

    return _transactionsController;
  }
}
