import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/bloc.dart';
import 'package:love_moneyyy/screen/add_transaction/widget/transaction_group_picking.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/widget.dart';

import 'widget/pick_image_dialog.dart';
import 'widget/wallet_picking.dart';

class AddTransactionScreen extends StatefulWidget {
  final AddTransactionBloc _addTransactionBloc = new AddTransactionBloc();
  @override
  AddTransactionScreenState createState() => AddTransactionScreenState();
}

class AddTransactionScreenState extends State<AddTransactionScreen> {
  var size = TextStyle(fontSize: 20);
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _transactionNameController =
      new TextEditingController();
  TextEditingController _tripController = new TextEditingController();
  TextEditingController _eventController = new TextEditingController();
  TextEditingController _placeController = new TextEditingController();

  Widget _body;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      widget._addTransactionBloc.dispatch(
          InitData(user: StoreProvider.of<UserState>(context).state.user));
    });
  }

  @override
  Widget build(BuildContext context) {
    _buildBody();
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm giao dịch'),
        centerTitle: true,
      ),
      body: _body,
    );
  }

  void _buildBody() {
    if (_body == null)
      _body = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _scanBill(),
            _inputPrice(),
            _transactionName(),
            _chooseGroup(),
            _chooseWallet(),
            _chooseTime(),
            _inputBillImage(),

            StreamBuilder(
              stream: widget._addTransactionBloc.showDetail,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Column(
                  children: <Widget>[
                    _chooseTrip(snapshot.data),
                    _chooseEvent(snapshot.data),
                    _choosePlace(snapshot.data),
                    _showDetail(snapshot.data),
                  ],
                );
              },
            ),
            //
            _saveButton(),
          ],
        ),
      );
  }

  Widget _scanBill() {
    return FlatButton(
      // onPressed: getImage,
      onPressed: () => _showDialog(),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.crop_free),
            Text('Scan hóa đơn', style: size),
          ],
        ),
      ),
    );
  }

  Widget _chooseGroup() {
    return StreamBuilder(
        stream: widget._addTransactionBloc.transactionType,
        builder: (context, AsyncSnapshot<TransactionType> snapshot) {
          if (!snapshot.hasData) return Container();

          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => new TransactionGroupPicking(
                    transactionType: snapshot.data,
                    addTransactionBloc: widget._addTransactionBloc,
                  ),
                ),
              );
            },
            leading: Text('Loại: ', style: size),
            title: Text(snapshot.data.description, style: size),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        });
  }

  Widget _chooseWallet() {
    return StreamBuilder(
        stream: widget._addTransactionBloc.wallet,
        builder: (context, AsyncSnapshot<Wallet> snapshot) {
          if (!snapshot.hasData) return Container();

          return ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WalletPicking(
                      walletPicked: snapshot.data,
                      addTransactionBloc: widget._addTransactionBloc,
                    ))),
            leading: Text('Ví: ', style: size),
            title: Text(snapshot.data.name, style: size),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        });
  }

  Widget _chooseTime() {
    return StreamBuilder<Object>(
        stream: widget._addTransactionBloc.date,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return InkWell(
            onTap: () {
              _showDatePicker(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Thời gian: ',
                    style: size,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        _showDatePicker(context);
                      },
                      child: Text(
                        Constants.formatter.format(snapshot.data),
                        textAlign: TextAlign.center,
                        style: size,
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          );
        });
  }

  Widget _inputPrice() {
    return StreamBuilder(
        stream: widget._addTransactionBloc.total,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != null) _priceController.text = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: widget._addTransactionBloc.onTotalChanged,
              controller: _priceController,
              keyboardType: TextInputType.number,
              onTap: () {
                widget._addTransactionBloc
                    .onTotalChanged(_priceController.text);
              },
              decoration: InputDecoration(
                labelText: 'Tổng thanh toán',
              ),
            ),
          );
        });
  }

  Widget _inputBillImage() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Text('Ảnh hóa đơn: ', style: size),
          Expanded(
            child: StreamBuilder(
                stream: widget._addTransactionBloc.imageFile,
                builder: (context, AsyncSnapshot<File> snapshot) {
                  return Container(
                    child: snapshot.data != null
                        ? Image.file(snapshot.data)
                        : Text('No image selected.'),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _chooseTrip(showDetail) {
    if (showDetail)
      return StreamBuilder(
          stream: widget._addTransactionBloc.trip,
          builder: (context, snapshot) {
            return Container(
              width: double.maxFinite,
              child: TextField(
                controller: _tripController,
                onTap: () => widget._addTransactionBloc
                    .onTripChanged(_tripController.text),
                onChanged: widget._addTransactionBloc.onTripChanged,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Chuyến đi'),
              ),
            );
          });
    else
      return Container();
  }

  Widget _chooseEvent(showDetail) {
    if (showDetail)
      return StreamBuilder(
          stream: widget._addTransactionBloc.event,
          builder: (context, snapshot) {
            return Container(
              width: double.maxFinite,
              child: TextField(
                controller: _eventController,
                onChanged: widget._addTransactionBloc.onEventChanged,
                onTap: () => widget._addTransactionBloc
                    .onEventChanged(_eventController.text),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Sự kiện'),
              ),
            );
          });
    else
      return Container();
  }

  Widget _choosePlace(showDetail) {
    if (showDetail)
      return StreamBuilder(
          stream: widget._addTransactionBloc.place,
          builder: (context, snapshot) {
            return TextField(
              controller: _placeController,
              onTap: () => widget._addTransactionBloc
                  .onPlaceChanged(_placeController.text),
              onChanged: widget._addTransactionBloc.onPlaceChanged,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Địa điểm'),
            );
          });
    else
      return Container();
  }

  Widget _showDetail(showDetail) {
    return FlatButton(
      onPressed: () {
        widget._addTransactionBloc.dispatch(ShowDetail());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            showDetail ? 'Ẩn chi tiết' : 'Thêm chi tiết',
            style: TextStyle(color: Colors.blue),
          ),
          Icon(
            showDetail ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget _transactionName() {
    return StreamBuilder(
        stream: widget._addTransactionBloc.transactionName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            width: double.maxFinite,
            child: TextField(
              controller: _transactionNameController,
              onChanged: widget._addTransactionBloc.onTransactionNameChanged,
              onTap: () => widget._addTransactionBloc
                  .onTransactionNameChanged(_transactionNameController.text),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Tên hóa đơn'),
            ),
          );
        });
  }

  Widget _saveButton() {
    return Container(
      child: BounceInAnimation(
        duration: Duration(seconds: 3),
        child: CirleButton(
          color: Colors.grey,
          onPressed: () => widget._addTransactionBloc.dispatch(SubmitSave()),
          title: 'Lưu',
        ),
      ),
    );
  }

  void _showDialog({AddTransactionBloc addTransactionBloc}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return PickImageDialog(
              addTransactionBloc: widget._addTransactionBloc);
        });
  }

  void _showDatePicker(context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030, 12, 30),
        initialDatePickerMode: DatePickerMode.day,
        initialDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (date != null) widget._addTransactionBloc.dispatch(DatePicker(date));
  }
}
