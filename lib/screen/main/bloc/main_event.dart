import 'package:equatable/equatable.dart';
import 'package:love_moneyyy/models/model.dart';

import 'bloc.dart';

class MainEvent extends Equatable {
  MainEvent({List props = const []}) : super();
}

class InitData extends MainEvent {
  final User user;
  InitData(this.user) : super();

  @override
  toString() => 'InitData {user: $user}';
}

class GetSummary extends MainEvent {
  GetSummary() : super();

  @override
  toString() => 'GetSummary';
}

class UpdateMainState extends MainEvent {
  final MainState mainState;
  UpdateMainState(this.mainState) : super();

  @override
  toString() => 'UpdateMainState {mainState: $mainState';
}

class OnLogOut extends MainEvent {
  OnLogOut() : super();

  @override
  toString() => 'OnLogOut';
}
