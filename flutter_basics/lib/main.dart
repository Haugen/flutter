import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': ['Green', 'Orange', 'Blue', 'Yellow'],
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': ['Panter', 'Snake', 'Jaguar', 'Lion'],
    },
    {
      'questionText': 'What is your favorite programming language?',
      'answers': ['JavaScript', 'Python', 'Dart', 'Go'],
    }
  ];

  var _questionIndex = 0;
  bool done = false;

  void _answerQuestion() {
    setState(() {
      _questionIndex++;
      if (_questionIndex >= questions.length) done = true;
    });
  }

  void _startOver() {
    setState(() {
      _questionIndex = 0;
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
              ? Center(
                  child: Column(
                    children: [
                      Text('All done!'),
                      RaisedButton(
                        child: Text('Start over'),
                        onPressed: _startOver,
                      )
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Question(
                      questionText: questions[_questionIndex]['questionText'],
                    ),
                    Column(
                      children: [
                        ...(questions[_questionIndex]['answers']
                                as List<String>)
                            .map((answer) => Answer(_answerQuestion, answer))
                            .toList()
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
