import 'package:love_moneyyy/redux/actions/actions.dart';
import 'package:love_moneyyy/redux/states/states.dart';

UserState userReducer(UserState currentState, dynamic action) {
  UserState newState = currentState;

  /// Add user
  if (action is AddUser) {
    newState = AuthenticatedUserState(action.user);
    return newState;
  }

  /// Changed User
  if (action is ChangeUser) {
    newState = AuthenticatedUserState(action.user);
    return newState;
  }

  /// Remove User
  if (action is RemoveUser) {
    newState = AuthenticatedUserState(null);
    return newState;
  }

  return newState;
}
