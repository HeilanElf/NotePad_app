import 'package:flutter/material.dart';

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
}