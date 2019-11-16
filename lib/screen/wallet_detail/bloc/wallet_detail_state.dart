import 'package:equatable/equatable.dart';

class WalletDetailState extends Equatable {
  WalletDetailState({List props = const []}) : super(props);
}

class WalletDetailInitial extends WalletDetailState {
  WalletDetailInitial() : super();

  @override
  toString() => "WalletDetailInitial";
}

class WalletDetailLoaded extends WalletDetailState {
  WalletDetailLoaded() : super();

  @override
  toString() => 'WalletDetailLoaded';
}
