import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoSearchScreen extends StatefulWidget {
  const MemoSearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MemoSearchScreenState createState() => _MemoSearchScreenState();
}

class _MemoSearchScreenState extends State<MemoSearchScreen> {
  late SharedPreferences _prefs;
  static const String _memoKey = 'memos';
  List<String> memos = [];

  TextEditingController memoController = TextEditingController();
  String memoSearchTerm = '';

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

  bool _matchesMemoSearchTerm(String searchTerm, String memo) {
    return memo.toLowerCase().contains(searchTerm.toLowerCase().trim());
  }

  Widget _buildSearchTextField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search Memo',
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: (value) {
        setState(() {
          memoSearchTerm = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo App Search'),
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
          _buildSearchTextField(),
          Expanded(
            child: ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memoIndex = memos.length - index;
                if (memoSearchTerm.isNotEmpty) {
                  if (!_matchesMemoSearchTerm(memoSearchTerm, memos[index])) {
                    return Container();
                  }
                }
                return ListTile(
                  title: Text('Memo $memoIndex: ${memos[index]}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
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
