import 'package:flutter/material.dart';
import 'package:love_moneyyy/redux/reducers/user_reducers.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/add_wallet/add_wallet_screen.dart';
import 'package:love_moneyyy/screen/index.dart';
import 'package:love_moneyyy/screen/register/register_screen.dart';
import 'package:love_moneyyy/util/routes_url.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'screen/login/login_screen.dart';
import 'screen/main/main.dart';

/* Routes of Love Moneyyy
*/
class Routes extends StatelessWidget {
  const Routes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Define Store to store user in applife.
    final userStore =
        new Store<UserState>(userReducer, initialState: InitUserState(null));

    /// Routes app
    return StoreProvider<UserState>(
        store: userStore,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LoveMoneyyyy',
            theme: ThemeData.light(),
            initialRoute: RoutesURL.login_screen,

            ///Routes
            routes: {
              // Login Screen
              RoutesURL.login_screen: (context) => LoginScreen(),

              /// Register Screen
              RoutesURL.register_screen: (context) => RegisterScreen(),

              /// Main Screen
              RoutesURL.main_screen: (context) => MainScreen(),

              /// Wallet Screen
              RoutesURL.wallet_screen: (context) => WalletScreen(),

              /// Add Wallet Screen
              RoutesURL.add_wallet_screen: (context) => AddWalletScreen(),

              // /// Choose Wallet Type Screen
              // RoutesURL.choose_wallet_type_screen: (context) =>
              //     WalletTypePicking(),

              // /// Choose Wallet Unit Money Screen
              // RoutesURL.choose_wallet_unit_money_screen: (context) =>
              //     WalletUnitMoneyPicking(),
            }));
  }
}
