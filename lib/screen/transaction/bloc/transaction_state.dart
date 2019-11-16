import 'package:equatable/equatable.dart';

class TransactionState extends Equatable {
  TransactionState({List props = const []}) : super();
}

class InitialState extends TransactionState {
  InitialState() : super();

  @override
  toString() => 'InittialState';
}
