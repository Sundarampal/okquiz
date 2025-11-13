import 'package:flutter/material.dart';
import 'package:okquiz/play.dart';
class Result extends StatelessWidget {
  final int score;
  final int total;
  final String quizId;
  final String quizTitle;
  final String questionsUrl;

  const Result({
    super.key,
    required this.score,
    required this.total,
    required this.quizId,
    required this.quizTitle,
    required this.questionsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      backgroundColor: const Color(0xFFF2E9FE),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Finished! Score: $score / $total',
              style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Play(
                      quizId: quizId,
                      quizTitle: quizTitle,
                      questionsUrl: questionsUrl,
                    ),
                  ),
                );
              },
              child: const Text('Retry Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
