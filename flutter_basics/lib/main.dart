import 'package:flutter/material.dart';

import './question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex = this._questionIndex == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['What is your name?', 'How old are you?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app!'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(35, 35, 35, 1), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Question(
                questionText: questions[_questionIndex],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      RaisedButton(
                        child: Text('Answer 1'),
                        onPressed: _answerQuestion,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RaisedButton(
                        child: Text('Answer 2'),
                        onPressed: _answerQuestion,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RaisedButton(
                        child: Text('Answer 3'),
                        onPressed: _answerQuestion,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
