import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/transaction/bloc/bloc.dart';
import 'package:love_moneyyy/util/constants.dart';
import 'package:love_moneyyy/util/converters.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/item/transaction_item.dart';

class TransactionScreen extends StatefulWidget {
  final TransactionBloc _transactionBloc = new TransactionBloc();
  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      widget._transactionBloc.dispatch(
          InitData(user: StoreProvider.of<UserState>(context).state.user));

      widget._transactionBloc.dispatch(GetAllTransaction());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _searchBar(),

          //
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                _pickTransactionType(),

                Padding(
                  padding: const EdgeInsets.all(10),
                ),

                ///
                _pickDateTime(),
              ],
            ),
          ),

          //
          _buildTransaction(),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[100],
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 30,
            ),
            suffixIcon: Icon(
              Icons.keyboard_voice,
              size: 30,
            ),
            hintText: 'Search',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickTransactionType() {
    return Expanded(
      child: StreamBuilder(
          stream: widget._transactionBloc.transactionTypes,
          builder: (context,
              AsyncSnapshot<List<TransactionType>> listTransactionType) {
            if (!listTransactionType.hasData) return Container();

            return Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1.0, color: Colors.black),
                color: Colors.grey[100],
              ),
              child: StreamBuilder(
                  stream: widget._transactionBloc.transactionType,
                  builder: (context, AsyncSnapshot<TransactionType> snapshot) {
                    if (!snapshot.hasData) return Container();

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<TransactionType>(
                        isExpanded: true,
                        value: snapshot.data,
                        onChanged: (value) {
                          widget._transactionBloc
                              .dispatch(ChooseTransactionType(value));
                        },
                        items: listTransactionType.data.map((value) {
                          return DropdownMenuItem<TransactionType>(
                            value: value,
                            child: Text(
                              value.description,
                              overflow: TextOverflow.fade,
                              style: Styles.text_field_style
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
            );
          }),
    );
  }

  Widget _pickDateTime() {
    return Expanded(
      child: StreamBuilder(
          stream: widget._transactionBloc.datetime,
          builder: (context, AsyncSnapshot<DateTime> snapshot) {
            if (!snapshot.hasData) return Container();

            return Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1.0, color: Colors.black),
                  color: Colors.grey[100],
                ),
                child: FlatButton.icon(
                  icon: Icon(Icons.calendar_today),
                  splashColor: Colors.grey[100],
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  label: Text(
                    '${Constants.dayFormatter.format(snapshot.data)}',
                    overflow: TextOverflow.fade,
                    style: Styles.text_field_style
                        .copyWith(color: Colors.grey[600]),
                  ),
                ));
          }),
    );
  }

  Widget _buildTransaction() {
    return Expanded(
      child: StreamBuilder(
          stream: widget._transactionBloc.transactions,
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            if (!snapshot.hasData) return Container();

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: snapshot.data[index]);
              },
            );
          }),
    );
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
    if (date != null) widget._transactionBloc.dispatch(PickingDateTime(date));
  }
}
