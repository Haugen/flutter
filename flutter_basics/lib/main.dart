import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': [
        {'text': 'Green', 'score': 4},
        {'text': 'Orange', 'score': 5},
        {'text': 'Blue', 'score': 6},
        {'text': 'Yellow', 'score': 3}
      ],
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': [
        {'text': 'Panter', 'score': 3},
        {'text': 'Snake', 'score': 8},
        {'text': 'Jaguar', 'score': 2},
        {'text': 'Lion', 'score': 5}
      ],
    },
    {
      'questionText': 'What is your favorite programming language?',
      'answers': [
        {'text': 'JavaScript', 'score': 2},
        {'text': 'Python', 'score': 4},
        {'text': 'Dart', 'score': 1},
        {'text': 'Go', 'score': 7}
      ],
    }
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  bool done = false;

  void _answerQuestion(int score) {
    setState(() {
      _questionIndex++;
      _totalScore += score;
      if (_questionIndex >= _questions.length) done = true;
    });
  }

  void _startOver() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      done = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app!'),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(35, 35, 35, 1), width: 2),
          ),
          child: done
              ? Result(_startOver, _totalScore)
              : Quiz(_questions, _answerQuestion, _questionIndex),
        ),
      ),
    );
  }
}
