import 'package:flutter/material.dart';
import 'calculator.dart';
import 'notes.dart';
import 'search.dart';
import 'game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedTabIndex = 0;

  List<Widget> _tabList = [
    Notes(),
    Search(),
    Calculator(),
    Game(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Bar App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar App'),
        ),
        backgroundColor: Color.fromARGB(255, 168, 206, 244), //这里设置为灰色
        body: _tabList[_selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.gamepad),
              label: 'Game',
            ),
          ],
          currentIndex: _selectedTabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
