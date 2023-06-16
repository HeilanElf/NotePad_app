import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final String _notesKey = 'notes';

  List<Map<String, dynamic>> _notes = [];

  // ignore: prefer_final_fields
  TextEditingController _noteController = TextEditingController();

  void _addNote() async {
  setState(() {
    _notes = List.from(_notes)
      ..add({
        'text': _noteController.text,
        'completed': false,
      });
  });

  // 持久化笔记数据到设备
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(_notesKey, _notes.map((note) => note['text'].toString()).toList());

  _noteController.clear();
}


  void _removeNoteAtIndex(int index) async {
    setState(() {
      _notes.removeAt(index);
    });

    // 更新设备上的笔记数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_notesKey, _notes.map((note) => note['text'].toString()).toList());

  }

  void _toggleNoteAtIndex(int index) async {
    setState(() {
      _notes[index]['completed'] = !_notes[index]['completed'];
    });

    // 更新设备上的笔记数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_notesKey, _notes.map((note) => note['text'].toString()).toList());

  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList(_notesKey) ?? [];
    setState(() {
      _notes = notes.map((note) => {'text': note, 'completed': false}).toList();
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool _matchesSearchTerm(String searchTerm, String text) {
    return text.toLowerCase().contains(searchTerm.toLowerCase().trim());
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: _noteController,
      decoration: const InputDecoration(
        hintText: 'Add a new note',
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onSubmitted: (value) => _addNote(),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (BuildContext context, int index) {
        if (_searchTerm.isNotEmpty) {
          if (!_matchesSearchTerm(_searchTerm, _notes[index]['text'])) {
            return Container();
          }
        }

        TextStyle textStyle = const TextStyle();

        if (_notes[index]['completed']) {
          textStyle = TextStyle(
            decoration: TextDecoration.combine([TextDecoration.lineThrough]),
          );
        }

        return Dismissible(
          key: Key(_notes[index]['text']),
          onDismissed: (direction) => _removeNoteAtIndex(index),
          background: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: ListTile(
            title: Text(_notes[index]['text'], style: textStyle),
            onTap: () {
              _toggleNoteAtIndex(index);
            },
          ),
        );
      },
    );
  }

  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchTextField(),
        Expanded(
          child: _buildNotesList(),
        ),
      ],
    );
  }
}