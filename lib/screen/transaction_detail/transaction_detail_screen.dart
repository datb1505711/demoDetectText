import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatefulWidget {
  TransactionDetailScreenState createState() => TransactionDetailScreenState();
}

class TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết hóa đơn",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}
