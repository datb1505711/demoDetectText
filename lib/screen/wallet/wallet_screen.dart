import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_moneyyy/redux/states/states.dart';
import 'package:love_moneyyy/screen/wallet/bloc/bloc.dart';
import 'package:love_moneyyy/screen/wallet/widgets/index.dart';
import 'package:love_moneyyy/util/util.dart';

class WalletScreen extends StatefulWidget {
  final WalletBloc _walletBloc = new WalletBloc();
  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      widget._walletBloc.dispatch(
          InitData(user: StoreProvider.of<UserState>(context).state.user));
      widget._walletBloc.dispatch(GetAllWallet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: //Tab bar
            SafeArea(
          top: true,
          bottom: true,
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              onTap: (index) {},
              tabs: <Widget>[
                Tab(
                  child: Text('Tài khoản'),
                ),
                Tab(
                  child: Text('Ví tiết kiệm'),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          /// Tabbar view
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ///
                  DefaultWallet(
                    walletBloc: widget._walletBloc,
                  ),

                  SavingWallet(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesURL.add_wallet_screen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
