import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/provider.dart';
import 'package:love_moneyyy/repositorys/repository.dart';
import 'package:love_moneyyy/screen/wallet/bloc/bloc.dart';
import 'package:rxdart/subjects.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository =
      new WalletRepository(new WalletProvider());

  BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  BehaviorSubject<List<Wallet>> _walletsController = new BehaviorSubject();
  BehaviorSubject<List<String>> _messagesController = new BehaviorSubject();
  BehaviorSubject<String> _countWalletMoneyController = new BehaviorSubject();

  List<Wallet> _wallets = [];
  User _user;
  int _countWalletMoney = 0;

  Stream<List<Wallet>> get wallets => _walletsController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<List<String>> get messages => _messagesController.stream;
  Stream<String> get countWalletMoney => _countWalletMoneyController.stream;

  @override
  WalletState get initialState => InitialWalletState();

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is RefreshWallet) yield* _mapRefershWalletToState(event);
    if (event is GetAllWallet) yield* _mapGetAllWalletToState(event);
    if (event is ShowDetailWallet) yield* _mapShowDetailWalletToState(event);
  }

  Stream<WalletState> _mapInitDataToState(InitData event) async* {
    _user = event.user;
  }

  Stream<WalletState> _mapGetAllWalletToState(GetAllWallet event) async* {
    _walletRepository.getAllWallet(username: _user.username).listen((wallets) {
      if (wallets != null) {
        _wallets = wallets;
        _walletsController.add(_wallets);

        wallets.forEach((wallet) {
          _countWalletMoney += int.parse(wallet.total);
        });

        print(_countWalletMoney);
        _countWalletMoneyController.add(_countWalletMoney.toString());
      }
    });
  }

  Stream<WalletState> _mapRefershWalletToState(RefreshWallet event) async* {}

  Stream<WalletState> _mapShowDetailWalletToState(
      ShowDetailWallet event) async* {}

  @override
  void dispose() {
    super.dispose();
    _loadingController?.close();
    _walletsController?.close();
    _countWalletMoneyController?.close();
    _messagesController?.close();
  }
}
