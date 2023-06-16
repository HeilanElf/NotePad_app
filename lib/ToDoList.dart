import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class TodoItem {
  final String title;
  final String description;
  final DateTime reminderTime;
  bool isCompleted;

  TodoItem({
    required this.title,
    required this.description,
    required this.reminderTime,
    this.isCompleted = false,
  });
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoItem> _todoItems = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _reminderTimeController = TextEditingController();

  Future<void> _selectReminderTime() async {
    final DateTime? selectedTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedTime != null) {
      final TimeOfDay? selectedHour = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedHour != null) {
        final DateTime selectedDateTime = DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          selectedHour.hour,
          selectedHour.minute,
        );

        final DateFormat formatter = DateFormat.yMd().add_jm();
        _reminderTimeController.text = formatter.format(selectedDateTime);
      }
    }
  }

  void _addTodoItem() {
    setState(() {
      final String title = _titleController.value.text;
      final String description = _descriptionController.value.text;
      final String reminderTimeAsString = _reminderTimeController.value.text;
      final DateFormat formatter = DateFormat.yMd().add_jm();
      final DateTime reminderTime = formatter.parse(reminderTimeAsString);

      _todoItems.add(
        TodoItem(
          title: title,
          description: description,
          reminderTime: reminderTime,
        ),
      );

      _titleController.clear();
      _descriptionController.clear();
      _reminderTimeController.clear();
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isCompleted = !_todoItems[index].isCompleted;
    });
  }

  void _deleteCompletedTodoItems() {
    setState(() {
      _todoItems.removeWhere((item) => item.isCompleted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[^\u4e00-\u9fa5]')),
              ],
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _reminderTimeController,
              decoration: InputDecoration(
                labelText: 'Reminder Time',
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () => _selectReminderTime(),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodoItem,
            child: Text('Add Todo'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (BuildContext context, int index) {
                final TodoItem item = _todoItems[index];

                return Dismissible(
                  key: Key(item.title),
                  onDismissed: (_) {
                    setState(() {
                      _todoItems.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                    alignment: Alignment.centerRight,
                  ),
                  child: CheckboxListTile(
                    value: item.isCompleted,
                    onChanged: (_) => _toggleTodoItem(index),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    secondary: Text(
                        '${DateFormat.yMd().add_jm().format(item.reminderTime)}'),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _deleteCompletedTodoItems,
            child: Text('Delete Completed'),
          ),
        ],
      ),
    );
  }
}