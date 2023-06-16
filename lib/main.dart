// ignore_for_file: library_private_types_in_public_api
//import 'search.dart';
import 'package:flutter/material.dart';
import 'package:gitpod_flutter_quickstart/ToDoList.dart';
import 'package:gitpod_flutter_quickstart/memo.dart';
import 'calculator.dart';
import 'ToDoList.dart';
import 'memo.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedTabIndex = 0;

  List<Widget> _tabList = [
    MemoApp(),
   // MemoSearchScreen(),
    TodoListPage(),
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
      title: 'Tool APP Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tool APP Demo'),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 206, 244), //这里设置为灰色
        body: _tabList[_selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note, size: 50, color: Colors.black),
              label: 'Memo_Notes',
            ),
           // BottomNavigationBarItem(
             // icon: Icon(Icons.search, size: 50, color: Colors.black),
              //label: 'Search',
            //),
            BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 50, color: Colors.black),
              label: 'To_do_list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate, size: 50, color: Colors.black),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.gamepad, size: 50, color: Colors.black),
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
