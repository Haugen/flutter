import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function startOver;
  final int totalScore;

  Result(this.startOver, this.totalScore);

  String get resultPhrase {
    var resultText;

    if (totalScore < 8) {
      resultText = 'Great score!!';
    } else if (totalScore <= 15) {
      resultText = 'Congratz. Not bad!';
    } else if (totalScore <= 22) {
      resultText = 'Not great but OK!';
    } else {
      resultText = 'What kind of monster are you?!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Your score was:' + totalScore.toString()),
          RaisedButton(
            child: Text('Start over'),
            onPressed: startOver,
          )
        ],
      ),
    );
  }
}
