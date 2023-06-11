
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _result = '0';

  void _onDigitButtonPressed(String text) {
    setState(() {
      _result = _result == '0' ? text : _result + ' ' + text;
    });
  }

  void _onAddButtonPressed() {
    setState(() {
      _result = _result + ' +';
    });
  }

  void _onSubtractButtonPressed() {
    setState(() {
      _result = _result + ' -';
    });
  }

  void _onMultiplyButtonPressed() {
    setState(() {
      _result = _result + ' *';
    });
  }

  void _onDivideButtonPressed() {
    setState(() {
      _result = _result + ' /';
    });
  }

  void _onClearButtonPressed() {
    setState(() {
      _result = '0';
    });
  }

  void _onCalculateButtonPressed() {
    setState(() {
      List<String> elements = _result.split(' ');
      double result = double.parse(elements[0]);
      for (int i = 1; i < elements.length; i += 2) {
        switch (elements[i]) {
          case '+':
            result = result + double.parse(elements[i+1]);
            break;
          case '-':
            result = result - double.parse(elements[i+1]);
            break;
          case '*':
            result = result * double.parse(elements[i+1]);
            break;
          case '/':
            result = result / double.parse(elements[i+1]);
            break;
        }
      }
      _result = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _result,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.right,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDigitButton('7'),
            _buildDigitButton('8'),
            _buildDigitButton('9'),
            _buildFunctionButton('C', _onClearButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDigitButton('4'),
            _buildDigitButton('5'),
            _buildDigitButton('6'),
            _buildFunctionButton('*', _onMultiplyButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDigitButton('1'),
            _buildDigitButton('2'),
            _buildDigitButton('3'),
            _buildFunctionButton('/', _onDivideButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDigitButton('0'),
            _buildDigitButton('.'),
            _buildFunctionButton('+', _onAddButtonPressed),
            _buildFunctionButton('-', _onSubtractButtonPressed),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: RaisedButton(
            child: Text('Calculate'),
            onPressed: _onCalculateButtonPressed,
          ),
        ),
      ],
    );
  }

  Widget _buildDigitButton(String text) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
      onPressed: () => _onDigitButtonPressed(text),
    );
  }

  Widget _buildFunctionButton(String text, Function onPressed) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
      onPressed: text == 'C' ? onPressed as void Function()? : () => onPressed(),
    );
  }
}