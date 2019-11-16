import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_moneyyy/widget/widget.dart';

class MessagesDialog extends StatelessWidget {
  final List<String> messages;
  final onConfirm;
  final bool isSuccess;

  const MessagesDialog(
      {Key key, @required this.messages, this.onConfirm, this.isSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Icon(
        (isSuccess ?? false) ? Icons.check : Icons.error_outline,
        color: (isSuccess ?? false) ? Colors.green : Colors.red,
        size: 50,
      ),
      content: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: 100.0,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: messages
                        .map((message) => Container(
                            child: Text(
                              message,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            margin: EdgeInsets.only(top: 10)))
                        .toList()),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              RaisedHarpyButton(
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                  title: '  CLOSE  ',
                  backgroundColor:
                      (isSuccess ?? false) ? Colors.green : Colors.red),
              Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final List<String> messages;
  final onConfirm;

  const ConfirmDialog({
    Key key,
    this.messages,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text('Confirm'),
        content: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(minHeight: 100.0),
                child: Column(
                  children: [
                    // Messages
                    Column(
                        children: messages
                            .map((message) => Container(
                                child: Text(
                                  message,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                margin: EdgeInsets.only(top: 10)))
                            .toList()),

                    SizedBox(height: 20.0),

                    // Buttons
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedHarpyButton(
                                backgroundColor: Colors.red,
                                title: "  NO ",
                                onPressed: () => Navigator.of(context).pop())),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedHarpyButton(
                                backgroundColor: Colors.green,
                                title: " YES ",
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onConfirm();
                                })),
                      ],
                    ),

                    Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10))
                  ],
                ))));
  }
}
