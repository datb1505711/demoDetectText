import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/model.dart';

class AddWalletEvent extends Equatable {
  AddWalletEvent({List props = const []}) : super([props]);
}

class InitData extends AddWalletEvent {
  final User user;
  InitData(this.user) : super();

  @override
  toString() => 'InitData';
}

class OnTapWalletType extends AddWalletEvent {
  OnTapWalletType() : super();
  @override
  toString() => 'OnTapWalletType';
}

class ChooseTypeWallet extends AddWalletEvent {
  final WalletType type;
  ChooseTypeWallet(this.type) : super();

  @override
  toString() => 'ChooseTypeWallet { type: $type}';
}

class OnTapUnitMoney extends AddWalletEvent {
  OnTapUnitMoney() : super();

  @override
  toString() => 'OnTapUnitMoney';
}

class ChooseUnitMoney extends AddWalletEvent {
  final WalletUnitMoney unit;
  ChooseUnitMoney(this.unit) : super();

  @override
  toString() => 'ChooseUnitMoney {unit: $unit}';
}

class SubmitCreate extends AddWalletEvent {
  SubmitCreate() : super();

  @override
  toString() => 'SubmitCreate';
}
