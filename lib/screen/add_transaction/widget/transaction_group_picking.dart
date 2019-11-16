import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/bloc.dart';

class TransactionGroupPicking extends StatelessWidget {
  final AddTransactionBloc _addTransactionBloc;
  final TransactionType _transactionType;

  TransactionGroupPicking(
      {@required AddTransactionBloc addTransactionBloc,
      @required TransactionType transactionType})
      : _addTransactionBloc = addTransactionBloc,
        this._transactionType = transactionType,
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chọn nhóm'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.backspace),
          ),
        ),
        body: StreamBuilder(
            stream: _addTransactionBloc.transactionTypes,
            builder: (context, AsyncSnapshot<List<TransactionType>> snapshot) {
              if (!snapshot.hasData) return Container();
              return RefreshIndicator(
                onRefresh: () async {
                  return _addTransactionBloc
                      .dispatch(new GetAllTransactionType());
                },
                child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _addTransactionBloc.dispatch(ChooseTransactionType(
                              transactionType: snapshot.data[index]));
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.beach_access),
                              Text(
                                snapshot.data[index].description,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
