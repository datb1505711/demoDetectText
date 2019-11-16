import 'package:flutter/material.dart';
import 'package:love_moneyyy/screen/account_management/account_management_screen.dart';
import 'package:love_moneyyy/util/preferences.dart';
import 'package:love_moneyyy/util/util.dart';

class OptionScreen extends StatefulWidget {
  // final UserRepository _userRepository =
  //     new UserRepository(userProvider: UserProvider());

  @override
  OptionScreenState createState() => new OptionScreenState();
}

class OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Tùy chọn',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountManagementScreen(),
                ));
              },
              leading: Icon(Icons.markunread_mailbox),
              title: Text('Quản lý tài khoản'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.language),
              title: Text('Ngôn ngữ'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.laptop_chromebook),
              title: Text('Tính lãi vay'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.laptop_mac),
              title: Text('Tra cứu thuế thu nhập cá nhân'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.laptop_windows),
              title: Text('Tra cứu tỉ giá'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text('Cài đặt'),
            ),
            ListTile(
              onTap: () {
                // widget._userRepository.logout();
                // StoreProvider.of(context).dispatch(RemoveUser());
                Preferences.removeUser();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutesURL.login_screen, (route) => false);
              },
              leading: Icon(Icons.exit_to_app),
              title: Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
