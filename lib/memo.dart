import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MemoApp());
}

class MemoApp extends StatelessWidget {
  const MemoApp({Key? key}) : super(key: key);

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
  late SharedPreferences _prefs;
  static const String _memoKey = 'memos';
  List<String> memos = [];

  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        memos = List<String>.from(_prefs.getStringList(_memoKey) ?? []);
      });
    });
  }

  void addMemo(String memo) {
    setState(() {
      memos.add(memo);
      _prefs.setStringList(_memoKey, memos);
    });
    memoController.clear();
  }

  void deleteMemo(int index) {
    setState(() {
      memos.removeAt(index);
      _prefs.setStringList(_memoKey, memos);
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
                final memoIndex = memos.length - index;
                return ListTile(
                  title: Text('Memo $memoIndex: ${memos[index]}'),
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




/*import 'package:flutter/material.dart';

void main() {
  runApp(const MemoApp());
}

class MemoApp extends StatelessWidget {
  const MemoApp({Key? key}) : super(key: key);

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
            final memoIndex = memos.length - index;
            return ListTile(
            title: Text('Memo $memoIndex: ${memos[index]}'),
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
*/