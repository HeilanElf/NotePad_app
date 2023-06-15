import 'package:flutter/material.dart';

void main() {
  runApp(MemoApp());
}

class MemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoScreen(),
    );
  }
}

class MemoScreen extends StatefulWidget {
  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  List<String> memos = [];

  TextEditingController memoController = TextEditingController();

  void addMemo(String memo) {
    setState(() {
      memos.add(memo);
    });
    memoController.clear();
  }

  void deleteMemo(int index) {
    setState(() {
      memos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: memoController,
              decoration: InputDecoration(
                labelText: 'Add Memo',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addMemo(memoController.text);
            },
            child: Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(memos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteMemo(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
