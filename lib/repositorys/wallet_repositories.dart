import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/wallet_provider.dart';
import 'package:rxdart/rxdart.dart';

class WalletRepository {
  final WalletProvider _walletProvider;

  WalletRepository(this._walletProvider);

  Subject<List<WalletType>> getWalletType() {
    return _walletProvider.getWalletType();
  }

  Subject<List<WalletUnitMoney>> getWalletUnitMoney() {
    return _walletProvider.getWalletUnitMoney();
  }

  Subject<Wallet> createWalllet(
      {@required String walletName,
      @required String username,
      @required String note,
      @required WalletType walletType,
      @required WalletUnitMoney walletUnitMoney,
      @required int total}) {
    return _walletProvider.createWallet(
        walletName: walletName,
        username: username,
        note: note,
        walletType: walletType,
        walletUnitMoney: walletUnitMoney,
        total: total);
  }

  Subject<List<Wallet>> getAllWallet({@required String username}) {
    return _walletProvider.getAllWallet(username: username);
  }
}
