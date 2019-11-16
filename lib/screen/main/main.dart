import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_moneyyy/screen/add_transaction/add_transaction_screen.dart';
import 'package:love_moneyyy/screen/index.dart';
import 'package:love_moneyyy/screen/main/bloc/bloc.dart';
import 'package:love_moneyyy/util/util.dart';
import 'package:love_moneyyy/widget/progress_indicators.dart';

class MainScreen extends StatefulWidget {
  final MainBloc _mainBloc = new MainBloc();
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  List<Widget> _items = [
    WalletScreen(),
    TransactionScreen(),
    AddTransactionScreen(),
    SummaryScreen(),
    OptionScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: widget._mainBloc,
        listener: (context, state) {
          print(state);
          if (state is LogOutMainState)
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesURL.login_screen, (route) => false);
        },
        child: Stack(
          children: <Widget>[
            IndexedStack(
              index: currentIndex,
              children: _items,
            ),

            /// Progress Loading
            StreamBuilder(
                stream: null,
                builder: (context, snapshot) {
                  return ProgressLoading(
                    containerColor: Colors.black,
                    color: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    loading: snapshot.data ?? false,
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(155, 148, 255, 1),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(155, 148, 255, 1),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Wallet'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transfer_within_a_station),
            title: Text('Bill'),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(child: Icon(Icons.add)),
            title: Text('Add Bills'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pan_tool),
            title: Text('Summary'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Options'),
          ),
        ],
      ),
    );
  }
}
