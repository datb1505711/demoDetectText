import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  MainState({List props = const []}) : super(props);
}

class InitialMainState extends MainState {
  InitialMainState() : super();

  @override
  toString() => 'InitialMainState';
}

class OnLoadMainState extends MainState {
  OnLoadMainState() : super();

  @override
  toString() => 'OnLoadMainState';
}

class LogOutMainState extends MainState {
  LogOutMainState() : super();

  @override
  toString() => 'LogOutMainState';
}
