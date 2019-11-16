import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:rxdart/rxdart.dart';

class WalletProvider {
  Subject<List<WalletType>> getWalletType() {
    BehaviorSubject<List<WalletType>> walletTypeSubject = new BehaviorSubject();

    List<WalletType> _walletsType = [];

    var response = Firestore.instance.collection('wallet_type').getDocuments();

    response.then((snapshot) async {
      if (snapshot.documents != null) {
        snapshot.documents.forEach((walletType) {
          var wallet = WalletType.fromJSON(walletType.data);
          _walletsType.add(wallet);
        });
        walletTypeSubject.add(_walletsType);
      } else
        walletTypeSubject.addError(['Get Wallet Type Error!']);
    }).whenComplete(() {
      walletTypeSubject?.close();
    });

    return walletTypeSubject;
  }

  ///
  Subject<List<WalletUnitMoney>> getWalletUnitMoney() {
    BehaviorSubject<List<WalletUnitMoney>> _walletsUnitMoneySubject =
        new BehaviorSubject();

    List<WalletUnitMoney> _walletsUnitMoney = [];

    var response =
        Firestore.instance.collection('wallet_unit_type').getDocuments();

    response.then((snapshot) {
      if (snapshot.documents != null) {
        snapshot.documents.forEach((unitMoney) {
          var _unitMoney = WalletUnitMoney.fromJSON(unitMoney.data);
          _walletsUnitMoney.add(_unitMoney);
        });
        _walletsUnitMoneySubject.add(_walletsUnitMoney);
      }
    }).whenComplete(() {
      _walletsUnitMoneySubject?.close();
    });

    return _walletsUnitMoneySubject;
  }

  /// Create Wallet
  Subject<Wallet> createWallet({
    String walletName,
    String username,
    String note,
    WalletType walletType,
    WalletUnitMoney walletUnitMoney,
    int total,
  }) {
    BehaviorSubject<Wallet> _walletSubject = new BehaviorSubject();

    int id;

    Map<String, dynamic> data = {};

    var maxId =
        Firestore.instance.collection('wallet_id').document('max_id').get();

    maxId.then((maxId) {
      id = maxId.data['max'];
      id++;
      data = {
        'id': id,
        'name': walletName,
        'username': username,
        'note': note,
        'total': total.toString(),
        'type': walletType.description,
        'unit': walletUnitMoney.description,
      };

      Firestore.instance
          .collection('wallet')
          .document()
          .setData(data)
          .then((value) {
        /// reset max id
        Firestore.instance
            .collection('wallet_id')
            .document('max_id')
            .setData({'max': id});
      });
    });

    var response = Firestore.instance.collection('wallet').getDocuments();

    response.then((value) {
      value.documents.forEach((_value) {
        var wallet = Wallet.fromJSON(_value.data);
        if (wallet.id == id.toString()) _walletSubject.add(wallet);
      });
    }, onError: (error) {
      _walletSubject.addError(error);
    }).whenComplete(() {
      _walletSubject?.close();
    });

    return _walletSubject;
  }

  Subject<List<Wallet>> getAllWallet({@required String username}) {
    BehaviorSubject<List<Wallet>> _walletsSubject = new BehaviorSubject();

    List<Wallet> _wallets = [];

    var response = Firestore.instance.collection('wallet').getDocuments();
    response.then((querySnapshot) {
      querySnapshot.documents.forEach((wallet) {
        var _wallet = Wallet.fromJSON(wallet.data);
        if (_wallet.username == username) _wallets.add(_wallet);
      });
      _wallets = Sort.sortListWallet(_wallets);
      _walletsSubject.add(_wallets);
    }, onError: (error) {
      _walletsSubject.addError(error);
    }).whenComplete(() {
      _walletsSubject?.close();
    });

    return _walletsSubject;
  }
}
