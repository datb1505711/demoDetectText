import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/model.dart';

class TransactionEvent extends Equatable {
  TransactionEvent({List props = const []}) : super([props]);
}

class InitData extends TransactionEvent {
  final User user;
  InitData({this.user}) : super();

  @override
  toString() => 'InitData';
}

class GetAllTransaction extends TransactionEvent {
  GetAllTransaction() : super();

  @override
  toString() => 'GetAllTransaction';
}

class ChooseTransactionType extends TransactionEvent {
  final TransactionType transactionType;
  ChooseTransactionType(this.transactionType) : super();

  @override
  toString() => 'ChooseTransctionType{ tranactionType: $transactionType}';
}

class PickingDateTime extends TransactionEvent {
  final DateTime datetime;
  PickingDateTime(this.datetime) : super();

  @override
  toString() => "PickingDateTime {datetime: $datetime } ";
}
