import 'package:flutter/material.dart';
import 'package:cryptoapp/home.dart';
import 'package:cryptoapp/wallet.dart';
import 'package:cryptoapp/profile.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CryptoApp', home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> children = [HomeScreen(), WalletScreen(), ProfileScreen()];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CryptoApp',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        backgroundColor: Colors.blue[900],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
              backgroundColor: Colors.blue[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              backgroundColor: Colors.blue[900])
        ],
      ),
    );
  }
}
