import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Map<String, dynamic>> _notes = [];

  TextEditingController _noteController = TextEditingController();

  void _addNote() {
    setState(() {
      _notes.add({
        'text': _noteController.text,
        'completed': false,
      });
    });
    _noteController.clear();
  }

  void _removeNoteAtIndex(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _toggleNoteAtIndex(int index) {
    setState(() {
      _notes[index]['completed'] = !_notes[index]['completed'];
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
      decoration: InputDecoration(
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
        if (_searchTerm != null && _searchTerm.isNotEmpty) {
          if (!_matchesSearchTerm(_searchTerm, _notes[index]['text'])) {
            return Container();
          }
        }

        TextStyle textStyle = TextStyle();

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
            child: Align(
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

  String _searchTerm="";

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