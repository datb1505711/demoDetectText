import 'package:equatable/equatable.dart';

class AddWalletState extends Equatable {
  AddWalletState({List props = const []}) : super(props);
}

class InitialState extends AddWalletState {
  InitialState() : super();

  @override
  toString() => 'InitialState';
}

class AddWalletLoading extends AddWalletState {
  AddWalletLoading() : super();

  @override
  toString() => 'AddWalletLoading';
}

class AddWalletLoaded extends AddWalletState {
  AddWalletLoaded() : super();

  @override
  toString() => 'AddWalletLoaded';
}
