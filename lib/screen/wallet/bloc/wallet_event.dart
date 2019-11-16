import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:love_moneyyy/models/model.dart';

class WalletEvent extends Equatable {
  WalletEvent({List props = const []}) : super([props]);
}

class InitData extends WalletEvent {
  final User user;
  InitData({@required this.user}) : super();
  @override
  toString() => 'InitData';
}

class ShowDetailWallet extends WalletEvent {
  final bool value;
  ShowDetailWallet({bool value})
      : value = value,
        super();

  @override
  toString() => 'ShowDetailWallet {value: $value}';
}

class GetAllWallet extends WalletEvent {
  GetAllWallet() : super();

  @override
  toString() => 'GetAllWallet';
}

class RefreshWallet extends WalletEvent {
  RefreshWallet() : super();
  @override
  toString() => 'RefreshWallet';
}
