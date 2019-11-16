class Converters {
  static const String dot = ",";
  static const int digits = 3;
  static int convertStringToInt(String string) {
    /// Define list string to store string item after split
    List<String> _strings = [];

    int _billNumber = 0;

    /// Define string after Split.
    String stringAfterSplit = "";

    if (string.contains(",")) {
      _strings = string.split(",");
      if (_strings[_strings.length - 1].length != 3)
        _strings[_strings.length - 1] = "";
    }
    if (string.contains(".")) {
      _strings = string.split(".");
      if (_strings[_strings.length - 1].length != 3)
        _strings[_strings.length - 1] = "";
    }
    if (string.contains(",") && string.contains(".")) {
      /// Remove number after dot in [string] input
      List<String> stringWithoutDot = string.split(".");
      _strings = stringWithoutDot[0].split(",");
    }

    _strings.forEach((string) {
      stringAfterSplit = stringAfterSplit + string;
    });
    try {
      _billNumber = int.parse(stringAfterSplit);
    } catch (e) {
      _billNumber = 0;
    }
    return _billNumber;
  }

  static String convertCurrency(String amount) {
    try {
      List result = amount.split("").reversed.toList();

      int count = (result.length / digits).floor();

      //  Loop to insert character
      for (var i = 1; i <= count; i++) {
        if (i == 1)
          result.insert(digits, dot);
        else
          result.insert((i * digits) + 1, dot);
      }

      if (result.last == dot) result.removeLast();

      return result.reversed.join();
    } catch (e) {
      return "Price invalid";
    }
  }
}
