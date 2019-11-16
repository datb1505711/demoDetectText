import 'messages.dart';

class Validators {
  static final RegExp usernameRegExp = RegExp(r'^[A-Za-z0-9]+$');
  static final RegExp passwordRegExp = RegExp(r'^[A-Za-z0-9]+$');

  /// Validate username
  static String validateUsername(String username) {
    if (username.isEmpty) return Messages.username_is_empty;
    if (username.length < 8)
      return Messages.usernmae_must_be_granter_than_8_characters;
    if (!usernameRegExp.hasMatch(username)) return Messages.name_invalid;

    return null;
  }

  /// Validate password
  static String validatePassword(String password) {
    if (password.isEmpty) return Messages.password_is_empty;
    if (password.length < 8)
      return Messages.password__must_be_greater_than_8_characters;
    if (!passwordRegExp.hasMatch(password)) return Messages.password_invalid;

    return null;
  }

  /// Validate name
  static String validateName(String name) {
    if (name.isEmpty) return Messages.name_is_empty;
    if (name.length < 4) return Messages.name_too_short;
    if (name.length > 255) return Messages.name_too_long;

    return null;
  }

  /// Validate email
  static String validateEmail(String email) {
    Pattern patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp emailRegExp = RegExp(patternEmail);

    if (email.isEmpty) return Messages.email_is_empty;
    if (!emailRegExp.hasMatch(email)) return Messages.email_invalid;

    return null;
  }

  /// Validate gender
  static String validateGender(String gender) {
    if (gender.isEmpty) return Messages.gender_is_empty;
    return null;
  }

  /// Validate phone number
  static String validatePhoneNumber(String phoneNum) {
    RegExp phoneNumberRegExp = RegExp(r'^[0-9]+$');

    if (phoneNum.isEmpty) return Messages.phone_is_empty;
    if (!phoneNumberRegExp.hasMatch(phoneNum))
      return Messages.phone_contain_special_character;
    if (phoneNum.length < 7 || phoneNum.length > 11)
      return Messages.phone_invalid;

    return null;
  }

  /// validate Wallet Total
  static String validateTotal(String total) {
    RegExp totalRegExp = RegExp(r'[0-9]+$');
    if (total.isEmpty) return Messages.please_input;
    if (!totalRegExp.hasMatch(total)) return Messages.number_total_invalid;
    return null;
  }

  /// Validate wallet name
  static String validateWalletName(String name) {
    if (name.isEmpty) return Messages.name_is_empty;
    return null;
  }

  static bool validateTextRegconized(String string) {
    final RegExp _reg = new RegExp(r'^[0-9,.]+$');
    String firstCharacter = string.split("")[0];

    /// if [string] have character 0-9 or . or ,
    if (_reg.hasMatch(string) && firstCharacter != "0") {
      if (string.contains(",") && string.contains(".")) {
        List<String> listStringWithoutDot = string.split(".");
        List<String> listStringAfterSplit = listStringWithoutDot[0].split(",");
        for (int i = 0; i < listStringAfterSplit.length - 1; i++)
          if (listStringAfterSplit[i].length > 3) return false;
      }
      if (string.contains(",")) {
        List<String> listStringAfterSplit = string.split(",");
        for (int i = 0; i < listStringAfterSplit.length - 1; i++)
          if (listStringAfterSplit[i].length > 3) return false;
      }
      if (string.contains(".")) {
        List<String> listStringAfterSplit = string.split(".");
        for (int i = 0; i < listStringAfterSplit.length - 1; i++)
          if (listStringAfterSplit[i].length > 3) return false;
      }
      return true;
    }

    return false;
  }
}
