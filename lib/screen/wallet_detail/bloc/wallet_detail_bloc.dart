import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/repositorys/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class WalletDetailBloc extends Bloc<WalletDetailEvent, WalletDetailState> {
  TransactionRepository _transactionRepository = new TransactionRepository();

  BehaviorSubject<List<String>> _messagesController = new BehaviorSubject();
  BehaviorSubject<String> _totalWalletMoneyController = new BehaviorSubject();
  BehaviorSubject<String> _walletMoneyInController = new BehaviorSubject();
  BehaviorSubject<String> _walletMoneyOutController = new BehaviorSubject();

  BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  BehaviorSubject<List<Transaction>> _transactionsController =
      new BehaviorSubject();

  Stream<List<Transaction>> get transactions => _transactionsController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<List<String>> get messages => _messagesController.stream;
  Stream<String> get total => _totalWalletMoneyController.stream;
  Stream<String> get walletMoneyIn => _walletMoneyInController.stream;
  Stream<String> get walletMoneyOut => _walletMoneyOutController.stream;

  User _user;
  @override
  WalletDetailState get initialState => WalletDetailInitial();

  @override
  Stream<WalletDetailState> mapEventToState(WalletDetailEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is GetAllTransaction) yield* _mapGetAllTransactionToState(event);
  }

  Stream<WalletDetailState> _mapInitDataToState(InitData event) async* {
    if (event.user != null) {
      _user = event.user;
    }
  }

  Stream<WalletDetailState> _mapGetAllTransactionToState(
      GetAllTransaction event) async* {
    _transactionRepository
        .getAllTransaction(username: _user.username)
        .listen((data) {
      _transactionsController.add(data);
    });
  }
}
