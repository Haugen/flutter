import 'package:flutter/material.dart';

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
    var questions = ['What is your name?', "How old are you?"];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(questions[_questionIndex]),
              RaisedButton(
                child: Text('Answer 1'),
                onPressed: _answerQuestion,
              ),
              RaisedButton(
                child: Text('Answer 2'),
                onPressed: _answerQuestion,
              ),
              RaisedButton(
                child: Text('Answer 3'),
                onPressed: _answerQuestion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
