import 'package:flutter/material.dart';
import 'package:love_moneyyy/models/model.dart';
import 'package:love_moneyyy/screen/wallet/bloc/bloc.dart';
import 'package:love_moneyyy/screen/wallet_detail/wallet_detail_screen.dart';
import 'package:love_moneyyy/util/converters.dart';

class DefaultWallet extends StatefulWidget {
  final WalletBloc _walletBloc;

  DefaultWallet({Key key, @required WalletBloc walletBloc})
      : _walletBloc = walletBloc,
        super(key: key);
  @override
  DefaultWalletState createState() => DefaultWalletState();
}

class DefaultWalletState extends State<DefaultWallet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 15.0,
            child: StreamBuilder(
                stream: widget._walletBloc.countWalletMoney,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  // if (!snapshot.hasData) return Container();

                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Tổng cộng',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          ' ${Converters.convertCurrency(snapshot.data)}',
                          style: TextStyle(color: Colors.red, fontSize: 16.0),
                        ),
                      ],
                    ),
                  );
                }),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          ),

          ///
          Expanded(
            child: StreamBuilder(
                stream: widget._walletBloc.wallets,
                builder: (context, AsyncSnapshot<List<Wallet>> snapshot) {
                  if (!snapshot.hasData) return Container();

                  return RefreshIndicator(
                    onRefresh: () async {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10.5),
                              right: Radius.circular(10.5))),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WalletDetail()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.5),
                                ),
                                elevation: 10.0,
                                child: Container(
                                  height: 200.0,
                                  padding: const EdgeInsets.all(12.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(155, 148, 255, 1)),
                                    borderRadius: BorderRadius.circular(12.5),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(' Tháng trước'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child:
                                                    Text('4,000,000/5,000,000'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 12.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                36,
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                            ),
                                          ),
                                          Container(
                                            height: 12.0,
                                            width: 200,
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  155, 148, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text('Tổng cộng'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child:
                                                    Text('4,000,000/5,000,000'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 12.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                36,
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                            ),
                                          ),
                                          Container(
                                            height: 12.0,
                                            width: 200,
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  155, 148, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
