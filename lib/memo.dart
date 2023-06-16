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
  List<String> searchResults = [];

  TextEditingController memoController = TextEditingController();
  TextEditingController searchController = TextEditingController();

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
      if (searchResults.isNotEmpty) {
        performSearch(searchController.text);
      }
    });
  }

  void performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults.clear();
        return;
      }
      final lowercaseQuery = query.toLowerCase();
      searchResults = memos.where((memo) {
        final lowercaseMemo = memo.toLowerCase();
        return lowercaseMemo.contains(lowercaseQuery);
      }).toList();
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Memo',
              ),
              onChanged: (value) {
                performSearch(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.isNotEmpty
                  ? searchResults.length
                  : memos.length,
              itemBuilder: (context, index) {
                final memoIndex = memos.length -
                    (searchResults.isNotEmpty
                        ? memos.indexOf(searchResults[index])
                        : index);
                return ListTile(
                  title: Text(
                      'Memo $memoIndex: ${searchResults.isNotEmpty ? searchResults[index] : memos[index]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          memoController.text = searchResults.isNotEmpty
                              ? searchResults[index]
                              : memos[index];
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
                                        if (searchResults.isNotEmpty) {
                                          final i = memos
                                              .indexOf(searchResults[index]);
                                          memos[i] = memoController.text;
                                          _prefs.setStringList(_memoKey, memos);
                                          performSearch(searchController.text);
                                        } else {
                                          memos[index] = memoController.text;
                                          _prefs.setStringList(_memoKey, memos);
                                        }
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
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          if (searchResults.isNotEmpty) {
                            final i = memos.indexOf(searchResults[index]);
                            deleteMemo(i);
                          } else {
                            deleteMemo(index);
                          }
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
