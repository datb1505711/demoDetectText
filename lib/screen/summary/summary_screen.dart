import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  @override
  SummaryScreenState createState() => SummaryScreenState();
}

class SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              /// Dayfrom -  Dayto
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(12.5)),
                      child: FlatButton(
                        child: Text(
                          "12/12/2017",
                          style: TextStyle(fontSize: 23),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),

                  //
                  SizedBox(width: 20.0),

                  //
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(12.5)),
                      child: FlatButton(
                        child: Text(
                          "13/12/2017",
                          style: TextStyle(fontSize: 23),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),

              /// Chart
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 8.0),
                color: Colors.black,
              )),

              ///
              SizedBox(width: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
