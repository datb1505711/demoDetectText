class RoutesURL {
  /// Prefix Route
  static const String prefix = "/";

  /// Login Screen
  static const String login_screen = prefix;

  /// Register Screen
  static const String register_screen = prefix + "register";

  /// Main Screen
  static const String main_screen = prefix + "main";

  /// Wallet Screen
  static const String wallet_screen = prefix + 'wallet_screen';

  /// Add Wallet Screen
  static const String add_wallet_screen = wallet_screen + '/add_wallet_screen';

  /// Choose Wallet Type Screen
  static const String choose_wallet_type_screen =
      add_wallet_screen + '/choose_wallet_type_screen';

  /// Choose Wallet Unit Money Screen
  static const String choose_wallet_unit_money_screen =
      add_wallet_screen + '/choose_wallet_unit_money_screen';
}
