import 'dart:math';
import 'package:flutter/material.dart';


void main() => runApp(const Cursfluttertema3());

class Cursfluttertema3 extends StatelessWidget {
  const Cursfluttertema3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess my number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GuessMyNumber(),
    );
  }
}

class GuessMyNumber extends StatefulWidget {
  const GuessMyNumber({super.key});

  @override
  _GuessMyNumberState createState() => _GuessMyNumberState();
}

class _GuessMyNumberState extends State<GuessMyNumber> {
  late int _numberToGuess;
  late int _numTries;
  late bool _gameOver;
  late String _message;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _numberToGuess = Random().nextInt(100) + 1;
      _numTries = 10;
      _gameOver = false;
      _message = "I'm thinking of a number between 1 and 100";
      _textController.clear();
    });
  }

  void _checkGuess() {
    final String input = _textController.text;
    int guess;
    try {
      guess = int.parse(input);
    } catch (e) {
      _showAlertDialog('Invalid input', 'Please enter a number');
      return;
    }
    setState(() {
      _numTries--;
      if (guess == _numberToGuess) {
        _message = 'You guessed right!';
        _gameOver = true;
      } else if (_numTries == 0) {
        _message = "Sorry, you're out of tries. The number was $_numberToGuess.";
        _gameOver = true;
      } else {
        _message = guess > _numberToGuess ? 'Too high' : 'Too low';
      }
    });
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Guess my number'),
        ),

         body: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      TextField(
                            controller: _textController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Guess the number'
                            ),
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                      onPressed: _gameOver ? _resetGame : _checkGuess,
                      child: Text(_gameOver ? 'Play again' : 'Guess'),
                  ),
                      const SizedBox(height: 16),
                      Text(
                      _message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                  ),
                       const SizedBox(height: 16),
                       Text(
                        'Tries left: $_numTries',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                  ),
            ],
          ),
    ),
    );
  }
}
