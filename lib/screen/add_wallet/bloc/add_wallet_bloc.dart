import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/provider.dart';
import 'package:love_moneyyy/repositorys/repository.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:rxdart/subjects.dart';

import 'bloc.dart';

class AddWalletBloc extends Bloc<AddWalletEvent, AddWalletState> {
  WalletRepository _walletRepository =
      new WalletRepository(new WalletProvider());

  final BehaviorSubject<WalletType> _walletTypeController =
      new BehaviorSubject();
  final BehaviorSubject<WalletUnitMoney> _walletUnitMoneyController =
      new BehaviorSubject();
  final BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  final BehaviorSubject<bool> _enableSaveingController = new BehaviorSubject();
  final BehaviorSubject<List<String>> _messagesController =
      new BehaviorSubject();
  final BehaviorSubject<String> _walletNameController = new BehaviorSubject();
  final BehaviorSubject<String> _walletNoteController = new BehaviorSubject();
  final BehaviorSubject<String> _walletTotalController = new BehaviorSubject();
  final BehaviorSubject<List<WalletType>> _walletsTypeController =
      new BehaviorSubject();
  final BehaviorSubject<List<WalletUnitMoney>> _walletsUnitMoneyController =
      new BehaviorSubject();

  List<WalletType> _walletsType = [];
  List<WalletUnitMoney> _walletsUnitMoney = [];
  User _user;
  String _name, _total;

  Stream<bool> get enableSaving => _enableSaveingController.stream;
  Stream<WalletType> get walletType => _walletTypeController.stream;
  Stream<WalletUnitMoney> get walletUnitMoney =>
      _walletUnitMoneyController.stream;
  Stream<List<String>> get messages => _messagesController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<List<WalletType>> get walletsType => _walletsTypeController.stream;
  Stream<List<WalletUnitMoney>> get walletsUnitMoney =>
      _walletsUnitMoneyController.stream;
  Stream<String> get note => _walletNoteController.stream;
  // Stream<String> get name => _walletNameController.stream;

  Function(String) get onTotalChanged => _walletTotalController.add;
  Function(String) get onNoteChanged => _walletNoteController.add;
  Function(String) get onNameChanged => _walletNameController.add;

  @override
  AddWalletState get initialState => InitialState();

  @override
  Stream<AddWalletState> mapEventToState(AddWalletEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is OnTapWalletType) yield* _mapOnTapWalletTypeToState(event);
    if (event is ChooseTypeWallet) yield* _mapChooseTypeWalletToState(event);
    if (event is OnTapUnitMoney) yield* _mapOnTapUnitMoneyToState(event);
    if (event is ChooseUnitMoney) yield* _mapChooseUnitMoneyToState(event);
    if (event is SubmitCreate) yield* _mapSubmitCreateToState(event);
  }

  Stream<AddWalletState> _mapSubmitCreateToState(SubmitCreate event) async* {
    _loadingController.add(true);

    var wallet = _walletRepository.createWalllet(
      walletName: _walletNameController.value,
      walletType: _walletTypeController.value,
      username: _user.username,
      walletUnitMoney: _walletUnitMoneyController.value,
      note: _walletNoteController.value,
      total: int.parse(_walletTotalController.value),
    );

    wallet.listen((data) {}, onError: (error) {
      _messagesController.addError(error);
    }).onDone(() {
      _loadingController.add(false);
      _messagesController.add(['Create wallet successful']);
      wallet?.close();
    });
  }

  Stream<String> get total => _walletTotalController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (total, sink) {
        var validResult = Validators.validateTotal(total.toString());
        validResult == null
            ? sink.add(total.toString())
            : sink.addError(validResult);

        validResult == null ? _total = total : _total = null;
        validateSaveButton();
      }));
  Stream<String> get name => _walletNameController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (name, sink) {
        var validResult = Validators.validateWalletName(name);
        validResult == null ? sink.add(name) : sink.addError(validResult);
        validResult == null ? _name = name : _name = null;
        validateSaveButton();
      }));

  void validateSaveButton() {
    if (_name != null && _total != null) {
      _enableSaveingController.add(true);
    } else
      _enableSaveingController.add(false);
  }

  Stream<AddWalletState> _mapInitDataToState(InitData event) async* {
    _loadingController.add(true);
    _enableSaveingController.add(false);

    await getAllWalletType();

    await getAllWalletUnitMoney();

    _walletsUnitMoneyController.add(_walletsUnitMoney);
    _walletsTypeController.add(_walletsType);
    _loadingController.add(false);

    _user = event.user;
  }

  Stream<AddWalletState> _mapChooseTypeWalletToState(
      ChooseTypeWallet event) async* {
    _walletTypeController.add(event.type);
  }

  Stream<AddWalletState> _mapChooseUnitMoneyToState(
      ChooseUnitMoney event) async* {
    _walletUnitMoneyController.add(event.unit);
  }

  /// get all wallet Type
  Future getAllWalletType() async {
    _walletRepository.getWalletType().listen((walletsType) {
      if (walletsType != null)
        walletsType.forEach((item) {
          _walletsType.add(item);
        });
      _walletsType = sortWalletType(_walletsType);
    }, onError: (error) {
      _messagesController.add(error);
    }).onDone(() {
      _walletTypeController.add(_walletsType[0]);
    });
  }

  /// get all wallet unit money
  Future getAllWalletUnitMoney() async {
    _walletRepository.getWalletUnitMoney().listen((walletUnitMoney) {
      if (walletUnitMoney != null)
        walletUnitMoney.forEach((item) {
          _walletsUnitMoney.add(item);
        });

      _walletsUnitMoney = sortWalletUnitMoney(_walletsUnitMoney);
    }, onError: (error) {
      _messagesController.add(error);
    }).onDone(() {
      _walletUnitMoneyController.add(_walletsUnitMoney[0]);
    });
  }

  Stream<AddWalletState> _mapOnTapUnitMoneyToState(
      OnTapUnitMoney event) async* {}

  Stream<AddWalletState> _mapOnTapWalletTypeToState(
      OnTapWalletType event) async* {}

  /// sort list wallet type
  List<WalletType> sortWalletType(List<WalletType> list) {
    WalletType temp;
    List<WalletType> _list = list;

    for (int i = 0; i < _list.length; i++)
      for (int j = i + 1; j < _list.length; j++) {
        if (_list[i].id > _list[j].id) {
          temp = _list[i];
          _list[i] = _list[j];
          _list[j] = temp;
        }
      }

    return _list;
  }

  /// sort list wallet unit money
  List<WalletUnitMoney> sortWalletUnitMoney(List<WalletUnitMoney> list) {
    var temp;
    List<WalletUnitMoney> _list = list;

    for (int i = 0; i < _list.length; i++)
      for (int j = i + 1; j < _list.length; j++) {
        if (_list[i].id > _list[j].id) {
          temp = _list[i];
          _list[i] = _list[j];
          _list[j] = temp;
        }
      }

    return _list;
  }

  @override
  void dispose() {
    super.dispose();
    _walletTypeController?.close();
    _walletUnitMoneyController?.close();
    _loadingController?.close();
    _enableSaveingController?.close();
    _messagesController?.close();
    _walletNameController?.close();
    _walletNoteController?.close();
    _walletTotalController?.close();
    _walletsTypeController?.close();
    _walletsUnitMoneyController?.close();
  }
}
