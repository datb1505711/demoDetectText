import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/main/bloc/bloc.dart';
import 'package:love_moneyyy/util/preferences.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  BehaviorSubject<List<String>> _messagesController = new BehaviorSubject();
  BehaviorSubject<bool> _loadingController = new BehaviorSubject();

  User _user;

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is GetSummary) yield* _mapGetSummaryToState(event);
    if (event is UpdateMainState) yield* _mapUpdateMainState(event);
    if (event is OnLogOut) yield* _mapOnLogOutToState(event);
  }

  Stream<MainState> _mapInitDataToState(InitData event) async* {
    _loadingController.add(false);
    _user = event.user;
  }

  Stream<MainState> _mapGetSummaryToState(GetSummary event) async* {}

  Stream<MainState> _mapUpdateMainState(UpdateMainState event) async* {
    yield event.mainState;
  }

  Stream<MainState> _mapOnLogOutToState(OnLogOut event) async* {
    await Preferences.removeUser();
    dispatch(UpdateMainState(LogOutMainState()));
    print(currentState);
  }

  @override
  void dispose() {
    super.dispose();
    _loadingController?.close();
    _messagesController?.close();
  }
}
