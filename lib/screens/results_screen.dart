import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:jona_quiz/data/questions.dart';
import 'package:jona_quiz/widgets/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summaryList = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summaryList.add({
        'question_index': i,
        'question_text': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summaryList;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: 'You Scored: ',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 194, 194, 218),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '$numCorrectQuestions',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 9, 19, 88),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' out of ',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 9, 19, 88),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '$numTotalQuestions',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      color: Color.fromARGB(255, 9, 19, 88),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.refresh, size: 20, color: Colors.white),
              onPressed: () {
                onRestart();
              },
              label: Text(
                'Restart Quiz',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
