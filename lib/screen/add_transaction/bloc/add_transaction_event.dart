import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:love_moneyyy/models/model.dart';

class AddTransactionEvent extends Equatable {
  AddTransactionEvent({List props = const []}) : super([props]);
}

class InitData extends AddTransactionEvent {
  final User user;
  InitData({@required this.user}) : super();

  @override
  toString() => 'InitData {user: $user}';
}

class ChooseWallet extends AddTransactionEvent {
  final Wallet wallet;
  ChooseWallet({@required this.wallet}) : super();

  @override
  toString() => 'ChooseWallet {wallet: $wallet}';
}

class ChooseTransactionType extends AddTransactionEvent {
  final TransactionType transactionType;
  ChooseTransactionType({@required this.transactionType}) : super();

  @override
  toString() => 'ChooseTransactionType {transactionType: $transactionType}';
}

class ScanBill extends AddTransactionEvent {
  ScanBill() : super();

  @override
  toString() => 'ScanBill';
}

class SubmitSave extends AddTransactionEvent {
  SubmitSave() : super();

  @override
  toString() => 'SubmitSave';
}

class GetAllTransactionType extends AddTransactionEvent {
  GetAllTransactionType() : super();

  @override
  toString() => 'GetAllTransactionType';
}

class DatePicker extends AddTransactionEvent {
  final DateTime date;
  DatePicker(this.date) : super();

  @override
  toString() => 'DatePicker {date: $date}';
}

class ShowDetail extends AddTransactionEvent {
  ShowDetail() : super();

  @override
  toString() => 'ShowDetail';
}

class PickingImage extends AddTransactionEvent {
  final File image;

  PickingImage(this.image) : super();

  @override
  toString() => 'PickingImage {File: $image}';
}

class GetAllWallet extends AddTransactionEvent {
  GetAllWallet() : super();

  @override
  toString() => 'GetAllWallet';
}

class GetAllTransactionGroup extends AddTransactionEvent {
  GetAllTransactionGroup() : super();

  @override
  toString() => 'GetAllTransactionGroup';
}
