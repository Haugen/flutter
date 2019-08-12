import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function startOver;

  Result(this.startOver);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('All done!'),
          RaisedButton(
            child: Text('Start over'),
            onPressed: startOver,
          )
        ],
      ),
    );
  }
}
