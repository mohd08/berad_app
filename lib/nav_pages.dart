import 'package:flutter/material.dart';
import 'package:web_socket/screens/graph_page.dart';
import 'package:web_socket/screens/history_page.dart';
import 'package:web_socket/screens/landing_page.dart';
import 'package:web_socket/screens/login_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Container(
      child: Center(child: const LandingScreen(title: 'Developers Readiness Challenge')),
      constraints: BoxConstraints.expand(),
    ),
    Container(
      child: Center(child: GraphScreen()),
      constraints: BoxConstraints.expand(),
    ),
    Container(
      child: Center(child: LoginScreen()),
      constraints: BoxConstraints.expand(),
    ),
    Container(
      child: Center(child: HistoryScreen()),
      constraints: BoxConstraints.expand(),
    ),
    Container(
      child: Center(child: LoginScreen()),
      constraints: BoxConstraints.expand(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 36,
              color: Colors.white,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              size: 36,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/explore.png', 
              width: 35,
              height: 35,
            ),
            label: 'Explore',
            activeIcon: Image.asset('assets/icons/explore.png',
              width:  35,
              height: 35,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/plus.png',
              width: 39,
              height: 39,
            ),
            label: 'Add',
            activeIcon: Image.asset('assets/icons/plus.png',
              width: 39,
              height: 39,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/history.png',
              width: 35,
              height: 35,
            ),
            label: 'History',
            activeIcon: Image.asset('assets/icons/history.png',
              width: 35,
              height: 35,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user.png',
              width: 35,
              height: 35,
            ),
            label: 'User',
            activeIcon: Image.asset('assets/icons/user.png',
              width: 35,
              height: 35,
              color: Colors.grey,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}