import 'package:intl/intl.dart';

class Constants {
  /// App's logo image
  static const app_logo = 'assets/logo.PNG';
  static const app_background = 'assets/background_picking.jpg';

  /// Date formatter
  static DateFormat formatter = DateFormat('dd - MM - yyyy');
  static DateFormat dayFormatter = DateFormat('dd/MM/yyyy');
  static DateFormat getDayOfWeek = DateFormat('EEEE');
  static DateFormat getDay = DateFormat('dd');

  /// Gender text
  static const List<String> genders = ['Male', 'Female'];

  /// Amount Currency
  static const List<String> amount_currency = [
    'VND',
    'Dolar',
    'Euro',
    'Yên',
    'NDT'
  ];

  /// Group text.
  static const List<String> groups = ['Shopping', 'Eating', 'Restaurant'];
}
