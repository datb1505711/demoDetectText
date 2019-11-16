import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/repositorys/repository.dart';
import 'package:love_moneyyy/screen/transaction/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionRepository _transactionRepository = new TransactionRepository();

  User _user;

  BehaviorSubject<List<String>> _messagesController = new BehaviorSubject();
  BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  BehaviorSubject<DateTime> _dateTimeController = new BehaviorSubject();
  BehaviorSubject<List<Transaction>> _transactionsController =
      new BehaviorSubject();
  BehaviorSubject<List<TransactionType>> _transactionTypesController =
      new BehaviorSubject();
  BehaviorSubject<TransactionType> _transactionTypeController =
      new BehaviorSubject();

  Stream<List<String>> get messages => _messagesController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<List<Transaction>> get transactions => _transactionsController.stream;
  Stream<DateTime> get datetime => _dateTimeController.stream;
  Stream<List<TransactionType>> get transactionTypes =>
      _transactionTypesController.stream;
  Stream<TransactionType> get transactionType =>
      _transactionTypeController.stream;

  @override
  TransactionState get initialState => InitialState();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is GetAllTransaction) yield* _mapGetAllTransactionToState(event);
    if (event is ChooseTransactionType)
      yield* _mapChooseTransactionTypeToState(event);
    if (event is PickingDateTime) yield* _mapPickingDateTimeToState(event);
  }

  Stream<TransactionState> _mapInitDataToState(InitData event) async* {
    _user = event.user;
    _dateTimeController.add(DateTime.now());
  }

  Stream<TransactionState> _mapGetAllTransactionToState(
      GetAllTransaction event) async* {
    _transactionRepository
        .getAllTransaction(username: _user.username)
        .listen((transactions) {
      _transactionsController.add(transactions);
    });

    _transactionRepository.getAllTransactionType().listen((transactionTypes) {
      _transactionTypesController.add(transactionTypes);
      _transactionTypeController.add(transactionTypes[0]);
    });
  }

  Stream<TransactionState> _mapChooseTransactionTypeToState(
      ChooseTransactionType event) async* {
    _transactionTypeController.add(event.transactionType);
  }

  Stream<TransactionState> _mapPickingDateTimeToState(
      PickingDateTime event) async* {
    _dateTimeController.add(event.datetime);
  }

  @override
  void dispose() {
    super.dispose();

    _messagesController?.close();
    _loadingController?.close();
  }
}
