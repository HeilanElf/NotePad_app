import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _targetNumber = Random().nextInt(100) + 1;
  int _guessNumber = 0;
  String _message = '';

  void _guess(int value) {
    setState(() {
      _guessNumber = value;
      if (_guessNumber > _targetNumber) {
        _message = 'Too high, try again';
      } else if (_guessNumber < _targetNumber) {
        _message = 'Too low, try again';
      } else {
        _message = 'Congratulations, you win!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Guess a number between 1 and 100:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => _guess(int.tryParse(value) ?? 0),
          decoration: InputDecoration(
            hintText: 'Enter a number',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        if (_guessNumber != 0)
          Text(
            'Your guess: $_guessNumber',
            style: TextStyle(fontSize: 20),
          ),
        SizedBox(height: 10),
        Text(
          _message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}