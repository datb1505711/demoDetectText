import 'package:equatable/equatable.dart';

class WalletState extends Equatable {
  WalletState({List props = const []}) : super();
}

class InitialWalletState extends WalletState {
  InitialWalletState() : super();

  @override
  toString() => 'InitialWallet';
}

class LoadingWallet extends WalletState {
  LoadingWallet() : super();

  @override
  toString() => 'LoadingWallet';
}

class LoadedWallet extends WalletState {
  LoadedWallet() : super();

  @override
  toString() => 'LoadedWallet';
}

class UpdateState extends WalletState {
  UpdateState() : super();

  @override
  toString() => 'UpdateState';
}
