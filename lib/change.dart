import 'package:flutter/material.dart';

class Converter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _result = 0;
  String _fromUnit = 'Year';
  String _toUnit = 'Week';

  void _convert() {
    final double inputValue = double.tryParse(_inputController.text) ?? 0;
    double convertedValue = 0;

    if (_fromUnit == 'Year' && _toUnit == 'Week') {
      convertedValue = inputValue * 52.143;
    } else if (_fromUnit == 'Year' && _toUnit == 'Day') {
      convertedValue = inputValue * 365;
    } else if (_fromUnit == 'Year' && _toUnit == 'Hour') {
      convertedValue = inputValue * 8760;
    } else if (_fromUnit == 'Week' && _toUnit == 'Year') {
      convertedValue = inputValue / 52.143;
    } else if (_fromUnit == 'Week' && _toUnit == 'Day') {
      convertedValue = inputValue * 7;
    } else if (_fromUnit == 'Week' && _toUnit == 'Hour') {
      convertedValue = inputValue * 168;
    } else if (_fromUnit == 'Day' && _toUnit == 'Year') {
      convertedValue = inputValue / 365;
    } else if (_fromUnit == 'Day' && _toUnit == 'Week') {
      convertedValue = inputValue / 7;
    } else if (_fromUnit == 'Day' && _toUnit == 'Hour') {
      convertedValue = inputValue * 24;
    } else if (_fromUnit == 'Hour' && _toUnit == 'Year') {
      convertedValue = inputValue / 8760;
    } else if (_fromUnit == 'Hour' && _toUnit == 'Week') {
      convertedValue = inputValue / 168;
    } else if (_fromUnit == 'Hour' && _toUnit == 'Day') {
      convertedValue = inputValue / 24;
    }

    setState(() {
      _result = convertedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('时间单位换算'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Convert from:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: <String>['Year', 'Week', 'Day', 'Hour']
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Convert to:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: <String>['Week', 'Year', 'Day', 'Hour']
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value to convert',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
