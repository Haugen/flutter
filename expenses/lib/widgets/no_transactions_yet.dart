import 'package:flutter/material.dart';

class NoTransactionsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('No transactions yet!'),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
