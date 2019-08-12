import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;

  Quiz(this.questions, this.answerQuestion, this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Question(
          questionText: this.questions[questionIndex]['questionText'],
        ),
        Column(
          children: [
            ...(questions[questionIndex]['answers'] as List<String>)
                .map((answer) => Answer(answerQuestion, answer))
                .toList()
          ],
        ),
      ],
    );
  }
}
