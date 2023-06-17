import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  bool _isCalculated = false;

  void _onDigitButtonPressed(String text) {
    setState(() {
      if (_isCalculated) {
        _expression = '';
        _isCalculated = false;
      }
      _expression += text;
    });
  }

  void _onOperatorButtonPressed(String text) {
    setState(() {
      if (_isCalculated) {
        _isCalculated = false;
      }
      _expression += ' ' + text + ' ';
    });
  }

  void _onClearButtonPressed() {
    setState(() {
      _expression = '';
      _isCalculated = false;
    });
  }

  void _onDeleteButtonPressed() {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    });
  }

  void _onEqualsButtonPressed() {
    setState(() {
      Parser p = Parser();
      Expression exp = p.parse(_expression);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      _expression = eval.toString();
      _isCalculated = true;
    });
  }

  void _onNegateButtonPressed() {
    setState(() {
      final lastChar = _expression.characters.last;
      if (lastChar == '-') {
        _expression = _expression.substring(0, _expression.length - 1);
      } else {
        _expression += '-';
      }
    });
  }

  void _onPercentButtonPressed() {
    setState(() {
      if (_expression.isEmpty) return;

      final lastChar = _expression.characters.last;
      if (lastChar == '%') return;

      final percentValue = double.parse(_expression) / 100.0;
      _expression = percentValue.toString();
    });
  }

  void _onParenthesisButtonPressed() {
    setState(() {
      if (_isCalculated) {
        _isCalculated = false;
      }
      _expression += '(';
    });
  }

  void _onRightParenthesisButtonPressed() {
    setState(() {
      _expression += ')';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCalculatorButton('C', onPressed: _onClearButtonPressed),
            _buildCalculatorButton('<', onPressed: _onDeleteButtonPressed),
            _buildCalculatorButton('%', onPressed: _onPercentButtonPressed),
            _buildCalculatorButton('.', onPressed: () => _onDigitButtonPressed('.')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCalculatorButton('7', onPressed: () => _onDigitButtonPressed('7')),
            _buildCalculatorButton('8', onPressed: () => _onDigitButtonPressed('8')),
            _buildCalculatorButton('9', onPressed: () => _onDigitButtonPressed('9')),
            _buildCalculatorButton('/', onPressed: () => _onOperatorButtonPressed('/')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCalculatorButton('4', onPressed: () => _onDigitButtonPressed('4')),
            _buildCalculatorButton('5', onPressed: () => _onDigitButtonPressed('5')),
            _buildCalculatorButton('6', onPressed: () => _onDigitButtonPressed('6')),
            _buildCalculatorButton('*', onPressed: () => _onOperatorButtonPressed('*')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCalculatorButton('1', onPressed: () => _onDigitButtonPressed('1')),
            _buildCalculatorButton('2', onPressed: () => _onDigitButtonPressed('2')),
            _buildCalculatorButton('3', onPressed: () => _onDigitButtonPressed('3')),
            _buildCalculatorButton('-', onPressed: () => _onOperatorButtonPressed('-')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCalculatorButton('(', onPressed: _onParenthesisButtonPressed),
            _buildCalculatorButton('0', onPressed: () => _onDigitButtonPressed('0')),
            _buildCalculatorButton(')', onPressed: _onRightParenthesisButtonPressed),
            _buildCalculatorButton('+', onPressed: () => _onOperatorButtonPressed('+')),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                '=',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: _onEqualsButtonPressed,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalculatorButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FlatButton(
        shape: CircleBorder(),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
        onPressed: onPressed,
      ),
    );
  }
}



/*
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
}*/