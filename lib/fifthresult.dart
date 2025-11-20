import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final int total;
  final String quizId;
  final String quizTitle;
  final String questionsUrl;

  final List<Map<String, dynamic>> userAnswers;

  const Result({
    super.key,
    required this.score,
    required this.total,
    required this.quizId,
    required this.quizTitle,
    required this.questionsUrl,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(

          children: [

            Center(
              child: Text(
                "Score: $score / $total",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            ...userAnswers.asMap().entries.map((entry) {
              int index = entry.key;
              var q = entry.value;

              return Card(
                color: q["is_correct"] ? Colors.green[50] : Colors.red[50],
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}. ${q['question']}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 8),

                      Text("Your Answer: ${q['selected_answer']}"),

                      Text("Correct Answer: ${q['correct_answer']}"),

                      SizedBox(height: 6),

                      Text(
                        q["is_correct"] ? "✔ Correct" : "✘ Wrong",
                        style: TextStyle(
                          fontSize: 16,
                          color: q["is_correct"] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
