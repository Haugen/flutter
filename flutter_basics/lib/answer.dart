import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function callback;
  final String answer;

  Answer(this.callback, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      child: RaisedButton(
        color: Colors.deepOrange[400],
        textColor: Colors.white,
        child: Text(answer),
        onPressed: callback,
      ),
    );
  }
}
