import 'package:flutter/material.dart';

class SavingWallet extends StatefulWidget {
  @override
  SavingWalletState createState() => SavingWalletState();
}

class SavingWalletState extends State<SavingWallet> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('click');
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tổng cộng',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    ' 5,000,000',
                    style: TextStyle(color: Colors.red, fontSize: 16.0),
                  ),
                ],
              ),
            ),

            ///
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                  color: Color.fromRGBO(155, 148, 255, 1)),
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ' Heo đất',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),

                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(' Tháng này'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text('4,000,000/5,000,000'),
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
                                      width: MediaQuery.of(context).size.width -
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
                                        color: Color.fromRGBO(155, 148, 255, 1),
                                        borderRadius:
                                            BorderRadius.circular(12.5),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text('Tổng cộng'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text('4,000,000/5,000,000'),
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
                                      width: MediaQuery.of(context).size.width -
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
                                        color: Color.fromRGBO(155, 148, 255, 1),
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
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
