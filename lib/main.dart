import 'package:flutter/material.dart';
import 'calculator.dart';
import 'notes.dart';
import 'search.dart';
import 'game.dart';
import 'ToDoList.dart';

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
    TodoListPage(),
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
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white, // 设置背景颜色为白色
            primaryColor: Colors.blue, // 将所选按钮颜色设置为蓝色
            textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.grey), // 设置标签文本颜色
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
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
                icon: Icon(Icons.gamepad),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'ToDo',
              ),
            ],
            currentIndex: _selectedTabIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
