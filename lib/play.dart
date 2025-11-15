import 'package:flutter/material.dart';
import 'package:okquiz/questionset.dart';
import 'package:okquiz/utilitiesdart.dart';

import 'fifthresult.dart';
class Play extends StatefulWidget {
  final String quizId;
  final String quizTitle;
  final String questionsUrl;

  const Play({
    super.key,
    required this.quizId,
    required this.quizTitle,
    required this.questionsUrl,
  });

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  QuestionSet? currentQuestionSet;
  int qIndex = 0;
  int score = 0;
  Set<String> answered = {};
  String notice = 'Loading questions...';

  @override
  void initState() {
    super.initState();
    _loadQuestionsForQuiz(widget.questionsUrl, widget.quizId);
  }

  Future<void> _loadQuestionsForQuiz(String questionsUrl, String quizId) async {
    currentQuestionSet = null;
    qIndex = 0;
    score = 0;
    answered.clear();
    setState(() => notice = 'Loading questions...');

    final remote = questionsUrl.isNotEmpty
        ? await Utilities.downloadJson(questionsUrl)
        : null;

    QuestionSet? parsedSet;

    if (remote != null) {
      if (remote is List) {
        final mapWrap = {
          'id': quizId,
          'title': widget.quizTitle,
          'questions': remote,
        };
        parsedSet = QuestionSet.fromJson(Map<String, dynamic>.from(mapWrap));
      } else if (remote is Map) {
        parsedSet = QuestionSet.fromJson(Map<String, dynamic>.from(remote));
      }
    }

    if (!mounted) return;

    if (parsedSet == null || parsedSet.questions.isEmpty) {
      setState(() {
        currentQuestionSet = null;
        notice = 'Failed to load questions.';
      });
      return;
    }

    setState(() {
      currentQuestionSet = parsedSet;
      notice = '';
    });
  }

  void _answerCurrent(bool selected) {
    final qs = currentQuestionSet;
    if (qs == null) return;

    final q = qs.questions[qIndex];
    if (answered.contains(q.id)) return;

    final correct = q.answer == selected;
    if (correct) score++;
    answered.add(q.id);
    setState(() {});
  }

  void _nextQuestion() {
    if (currentQuestionSet == null) return;
    if (qIndex < currentQuestionSet!.questions.length - 1) {
      setState(() => qIndex++);
    } else {
      _gotoResult();
    }
  }

  void _gotoResult() {
    final total = currentQuestionSet?.questions.length ?? 0;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Result(
          score: score,
          total: total,
          quizId: widget.quizId,
          quizTitle: widget.quizTitle,
          questionsUrl: widget.questionsUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qs = currentQuestionSet;

    if (qs == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.quizTitle)),
        backgroundColor: const Color(0xFFF2E9FE),
        body: Center(child: Text(notice)),
      );
    }

    final q = qs.questions[qIndex];
    final already = answered.contains(q.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.quizTitle)),
      backgroundColor: const Color(0xFFF2E9FE),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              qs.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${qIndex + 1} / ${qs.questions.length}',
              style: const TextStyle(color: Colors.green),
            ),
            const Divider(),
            Text(q.text, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: already ? null : () => _answerCurrent(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
              ), child:  const Text('True'),


            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: already ? null : () => _answerCurrent(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
              ), child:  const Text('False'),
            ),
            const SizedBox(height: 12),
            Text('Score: $score', style: const TextStyle(color: Colors.green)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: qIndex > 0 ? () => setState(() => qIndex--) : null,
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _gotoResult,
              child: const Text('Finish Now'),
            ),
          ],
        ),
      ),
    );
  }
}
