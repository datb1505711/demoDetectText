import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/providers/provider.dart';
import 'package:love_moneyyy/repositorys/repository.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/bloc.dart';
import 'package:love_moneyyy/util/converters.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:rxdart/rxdart.dart';

import 'package:firebase_storage/firebase_storage.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  WalletRepository _walletRepository =
      new WalletRepository(new WalletProvider());
  TransactionRepository _transactionRepository = new TransactionRepository();

  /// Define behaviorSubject controller
  BehaviorSubject<String> _totalController = new BehaviorSubject();
  BehaviorSubject<String> _transactionNameController = new BehaviorSubject();
  BehaviorSubject<String> _tripController = new BehaviorSubject();
  BehaviorSubject<String> _eventController = new BehaviorSubject();
  BehaviorSubject<String> _placeController = new BehaviorSubject();
  BehaviorSubject<bool> _showDetailController = new BehaviorSubject();
  BehaviorSubject<bool> _loadingController = new BehaviorSubject();
  BehaviorSubject<List<String>> _messagesController = new BehaviorSubject();
  BehaviorSubject<DateTime> _dateController = new BehaviorSubject();
  BehaviorSubject<List<Wallet>> _walletsController = new BehaviorSubject();
  BehaviorSubject<Wallet> _walletController = new BehaviorSubject();
  BehaviorSubject<List<TransactionType>> _transactionTypesController =
      new BehaviorSubject();
  BehaviorSubject<TransactionType> _transactionTypeController =
      new BehaviorSubject();
  BehaviorSubject<File> _imageFileController = new BehaviorSubject();

  /// define variable
  User _user;
  Transaction _transaction;
  List<Wallet> _wallets = [];
  List<TransactionType> _transactionTypes = [];

  /// get Stream
  Stream<DateTime> get date => _dateController.stream;
  Stream<File> get imageFile => _imageFileController.stream;
  Stream<bool> get loading => _loadingController.stream;
  Stream<bool> get showDetail => _showDetailController.stream;
  Stream<List<String>> get messages => _messagesController.stream;
  Stream<List<Wallet>> get wallets => _walletsController.stream;
  Stream<Wallet> get wallet => _walletController.stream;
  Stream<List<TransactionType>> get transactionTypes =>
      _transactionTypesController.stream;
  Stream<TransactionType> get transactionType =>
      _transactionTypeController.stream;
  Stream<String> get total => _totalController.stream;
  Stream<String> get trip => _tripController.stream;
  Stream<String> get event => _eventController.stream;
  Stream<String> get place => _placeController.stream;
  Stream<String> get transactionName => _transactionNameController.stream;

  /// get function
  Function(String) get onTotalChanged => _totalController.add;
  Function(String) get onTripChanged => _tripController.add;
  Function(String) get onEventChanged => _eventController.add;
  Function(String) get onPlaceChanged => _placeController.add;
  Function(String) get onTransactionNameChanged =>
      _transactionNameController.add;

  @override
  AddTransactionState get initialState => AddTransactionInitial();

  @override
  Stream<AddTransactionState> mapEventToState(
      AddTransactionEvent event) async* {
    if (event is InitData) yield* _mapInitDataToState(event);
    if (event is ScanBill) yield* _mapScanBillToState(event);
    if (event is SubmitSave) yield* _mapSubmitSaveToState(event);
    if (event is DatePicker) yield* _mapDatePickerToState(event);
    if (event is ShowDetail) yield* _mapShowDetailToState(event);
    if (event is GetAllWallet) yield* _mapGetAllWalletToState(event);
    if (event is PickingImage) yield* _mapPickingImageToState(event);
    if (event is GetAllTransactionType) yield* _mapGetAllTransactionType(event);
    if (event is ChooseWallet) yield* _mapChooseWalletToState(event);
    if (event is ChooseTransactionType)
      yield* _mapChooseTransactionTypeToState(event);
  }

  Stream<AddTransactionState> _mapInitDataToState(InitData event) async* {
    _dateController.add(DateTime.now());
    _showDetailController.add(false);
    _user = event.user;
    _loadingController.add(false);
    dispatch(GetAllWallet());
    dispatch(GetAllTransactionType());
  }

  Stream<AddTransactionState> _mapChooseWalletToState(
      ChooseWallet event) async* {
    _walletController.add(event.wallet);
  }

  Stream<AddTransactionState> _mapSubmitSaveToState(SubmitSave event) async* {
    uploadImage();
  }

  Future uploadImage() async {
    var filePath = 'image/${DateTime.now().millisecondsSinceEpoch}.png';

    try {
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child(filePath);
      StorageUploadTask _uploadTask = storageRef.putFile(
        _imageFileController.value,
      );
      StorageTaskSnapshot storageTaskSnapshot = await _uploadTask.onComplete;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      _transaction = new Transaction(
        createAt: _dateController.value,
        event: _eventController.value,
        imageURL: downloadUrl,
        name: _transactionNameController.value,
        place: _placeController.value,
        total: _totalController.value,
        transactionType: _transactionTypeController.value.description,
        trip: _tripController.value,
        walletId: _walletController.value.id,
        id: "0",
      );

      ///create Transaction
      _transactionRepository
          .createTransaction(transaction: _transaction)
          .listen((data) {
        print(data);
      });
    } catch (e) {
      _messagesController
          .addError(["cannot create new transaction, please try again"]);
    }
  }

  Stream<AddTransactionState> _mapChooseTransactionTypeToState(
      ChooseTransactionType event) async* {
    _transactionTypeController.add(event.transactionType);
  }

  Stream<AddTransactionState> _mapScanBillToState(ScanBill event) async* {}
  Stream<AddTransactionState> _mapDatePickerToState(DatePicker event) async* {
    _dateController.add(event.date);
  }

  Stream<AddTransactionState> _mapShowDetailToState(ShowDetail event) async* {
    _showDetailController.add(!_showDetailController.value);
  }

  Stream<AddTransactionState> _mapGetAllTransactionType(
      GetAllTransactionType event) async* {
    _transactionRepository.getAllTransactionType().listen((transactionTypes) {
      _transactionTypes = Sort.sortListTransactionType(transactionTypes);
      _transactionTypeController.add(_transactionTypes[0]);
      _transactionTypesController.add(_transactionTypes);
    });
  }

  Stream<AddTransactionState> _mapGetAllWalletToState(
      GetAllWallet event) async* {
    _walletRepository.getAllWallet(username: _user.username).listen((wallets) {
      _wallets = Sort.sortListWallet(wallets);
      _walletController.add(_wallets[0]);
      _walletsController.add(_wallets);
    });
  }

  Stream<AddTransactionState> _mapPickingImageToState(
      PickingImage event) async* {
    _imageFileController.add(event.image);

    readText();
  }

  // found bill total in image detective text
  readText() async {
    FirebaseVisionImage ourImage =
        FirebaseVisionImage.fromFile(_imageFileController.value);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    List<TextElement> listTextElement = [];
    List<TextElement> listNumber = [];
    int maxTotal = 0;
    double maxHeight = 0;
    await recognizeText.processImage(ourImage).then((val) {
      for (TextBlock block in val.blocks) {
        for (TextLine line in block.lines) {
          // Same getters as TextBlock
          for (TextElement element in line.elements) {
            listTextElement.add(element);
            print(
                '${element.text} + ${element.boundingBox.height} + ${element.boundingBox.width}');
          }
        }
      }

      /// get total in bill
      listTextElement.forEach((item) {
        var validResult = Validators.validateTextRegconized(item.text);
        if (validResult) listNumber.add(item);
      });

      /// check [listNumber], show error when not found number in image
      if (listNumber.isEmpty) {
        _messagesController.add(["Cannot read total in Your bill"]);
      } else {
        listNumber.forEach((item) {
          var number = Converters.convertStringToInt(item.text);
          if (item.boundingBox.height >= maxHeight &&
              number >= maxTotal &&
              number != 0) {
            maxHeight = item.boundingBox.height;

            maxTotal = number;
          }
        });

        _totalController.add(maxTotal.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _showDetailController?.close();
    _loadingController?.close();
    _messagesController?.close();
    _transactionNameController?.close();
    _tripController?.close();
    _eventController?.close();
    _placeController?.close();
  }
}
