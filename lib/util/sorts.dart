import 'package:love_moneyyy/models/model.dart';

class Sort {
  static List<TransactionType> sortListTransactionType(
      List<TransactionType> list) {
    for (int i = 0; i < list.length; i++)
      for (int j = i + 1; j < list.length; j++)
        if (list[i].id > list[j].id) {
          var temp = list[i];
          list[i] = list[j];
          list[j] = temp;
        }

    return list;
  }

  // sort list wallet
  static List<Wallet> sortListWallet(List<Wallet> list) {
    for (int i = 0; i < list.length; i++)
      for (int j = i + 1; j < list.length; j++)
        if (int.parse(list[i].id) > int.parse(list[j].id)) {
          var temp = list[i];
          list[i] = list[j];
          list[j] = temp;
        }

    return list;
  }
}
