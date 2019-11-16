import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/model.dart';

class WalletDetailEvent extends Equatable {
  WalletDetailEvent({List props = const []}) : super(props);
}

class InitData extends WalletDetailEvent {
  final User user;
  InitData(this.user) : super();

  @override
  toString() => 'InitData';
}

class GetAllTransaction extends WalletDetailEvent {
  GetAllTransaction() : super();

  @override
  toString() => 'GetALlTransaction';
}
