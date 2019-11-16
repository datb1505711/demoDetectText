import 'package:equatable/equatable.dart';

class AddTransactionState extends Equatable {
  AddTransactionState({List props = const []}) : super(props);
}

class AddTransactionLoading extends AddTransactionState {
  AddTransactionLoading() : super();

  @override
  toString() => 'AddTransactionLoading';
}

class AddTransactionInitial extends AddTransactionState {
  AddTransactionInitial() : super();

  @override
  toString() => 'AddTransactionInitial';
}

class AddTransactionLoaded extends AddTransactionState {
  AddTransactionLoaded() : super();

  @override
  toString() => 'AddTransactionLoaded';
}
