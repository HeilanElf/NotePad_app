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
          title: const Text('Tab Bar App'),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 206, 244), //这里设置为灰色
        body: _tabList[_selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note, size: 50, color: Colors.blue),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 50, color: Colors.black),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate, size: 50, color: Colors.purple),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.gamepad, size: 50, color: Colors.green),
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
