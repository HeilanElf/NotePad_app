import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoSearchScreen extends StatefulWidget {
  const MemoSearchScreen({Key? key}) : super(key: key);

  @override
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
      decoration: InputDecoration(
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
        title: Text('Memo App Search'),
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

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _notes = [
    'Buy milk',
    'Walk the dog',
    'Workout',
    'Prepare dinner',
    'abcdefghijklmnopqrstuvwxyz',
  ];

  List<String> _searchedNotes = [];

  void _onSearch(String value) {
    setState(() {
      _searchedNotes = List.from(_notes.where((note) => note.contains(value)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search notes',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchedNotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchedNotes[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}*/