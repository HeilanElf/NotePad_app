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
      home: const MemoScreen(),
    );
  }
}

class MemoScreen extends StatefulWidget {
  const MemoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        memoController = TextEditingController();
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
        title: const Text('Memo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: memoController,
              decoration: const InputDecoration(
                labelText: 'Add Memo',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addMemo(memoController.text);
            },
            child: const Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memoIndex = memos.length - index;
                return ListTile(
                  title: Text('Memo $memoIndex: ${memos[index]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          memoController.text = memos[index];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Edit Memo'),
                                content: TextField(
                                  controller: memoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Edit Memo',
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        memos[index] =
                                            memoController.text;
                                        _prefs.setStringList(
                                            _memoKey, memos);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteMemo(index);
                        },
                      ),
                    ],
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
