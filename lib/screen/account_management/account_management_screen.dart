import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  AccountManagementScreenState createState() =>
      new AccountManagementScreenState();
}

class AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý tài khoản',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Image.network(
                'http://loinoihay.net/wp-content/uploads/2016/04/15-h%C3%ACnh-%E1%BA%A3nh-c%E1%BB%B1c-%C4%91%E1%BA%B9p-d%C3%B9ng-l%C3%A0m-avata-cho-nh%E1%BB%AFng-ai-%C4%91ang-c%C3%B4-%C4%91%C6%A1n-th%E1%BA%A5t-t%C3%ACnh12.jpg',
                width: 200.0,
                height: 200.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
