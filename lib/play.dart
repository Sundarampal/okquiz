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

  /// ⭐ User Answers Save Here
  List<Map<String, dynamic>> userAnswers = [];

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
    userAnswers.clear();

    setState(() => notice = 'Loading questions...');

    final remote = questionsUrl.isNotEmpty
        ? await Utilities.downloadJson(questionsUrl)
        : null;

    QuestionSet? parsedSet;

    if (remote != null) {
      if (remote is List) {
        parsedSet = QuestionSet.fromJson({
          'id': quizId,
          'title': widget.quizTitle,
          'questions': remote,
        });
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

  /// ⭐ Answer Function (Corrected)
  void _answerCurrent(bool selectedValue) {
    final qs = currentQuestionSet;
    if (qs == null) return;

    final q = qs.questions[qIndex];
    if (answered.contains(q.id)) return;

    bool correct = q.answer == selectedValue;
    if (correct) score++;

    answered.add(q.id);

    // ⭐ Store user answer for Result Page
    userAnswers.add({
      "question": q.text,
      "correct_answer": q.answer == true ? "True" : "False",
      "selected_answer": selectedValue ? "True" : "False",
      "is_correct": correct,
    });

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

  /// ⭐ Passing questions + user answers to Result Page
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
          userAnswers: userAnswers,
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
        body: Center(child: Text(notice)),
      );
    }

    final q = qs.questions[qIndex];
    final already = answered.contains(q.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.quizTitle)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${qIndex + 1} / ${qs.questions.length}'),
            const Divider(),
            Text(q.text, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: already ? null : () => _answerCurrent(true),
                child: Center(child: const Text('True'),),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: already ? null : () => _answerCurrent(false),
              child: Center(child: const Text('False')),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: _nextQuestion,
              child: Center(child: const Text("Next")),
            ),
          ],
        ),
      ),
    );
  }
}
