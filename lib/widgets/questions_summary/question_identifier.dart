import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(
      {super.key, required this.questionIndex, required this.isCorrect});

  final int questionIndex;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final questionNum = questionIndex + 1;

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isCorrect
            ? const Color.fromARGB(255, 160, 248, 101)
            : const Color.fromARGB(255, 178, 57, 57),
      ),
      child: Text(
        questionNum.toString(),
        style: const TextStyle(
          color: Color.fromARGB(255, 22, 2, 56),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
