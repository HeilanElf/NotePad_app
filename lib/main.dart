// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:gitpod_flutter_quickstart/ToDoList.dart';
import 'package:gitpod_flutter_quickstart/memo.dart';
import 'calculator.dart';
import 'ToDoList.dart';
import 'memo.dart';
import 'game.dart';
import 'change.dart';
import 'splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Bar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // 显示闪屏页面
      routes: {
        '/home': (context) => Home(), // 主页面的路由
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTabIndex = 0;

  List<Widget> _tabList = [
    MemoApp(),
    // MemoSearchScreen(),
    TodoListPage(),
    Calculator(),
    Game(),
    Converter(),
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
              icon: Icon(Icons.gamepad, size: 50, color: Colors.black),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.change_circle, size: 50, color: Colors.black),
              label: 'Change',
            ),
          ],
          currentIndex: _selectedTabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}