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
  List<Map<String, dynamic>> userAnswers = [];

  String notice = "Loading questions...";

  @override
  void initState() {
    super.initState();
    _loadQuestions(widget.questionsUrl, widget.quizId);
  }

  Future<void> _loadQuestions(String url, String id) async {
    currentQuestionSet = null;
    answered.clear();
    userAnswers.clear();
    score = 0;
    qIndex = 0;

    setState(() => notice = "Loading questions...");

    final remote = await Utilities.downloadJson(url);

    QuestionSet? parsed;

    if (remote != null) {
      if (remote is List) {
        parsed = QuestionSet.fromJson({
          "id": id,
          "title": widget.quizTitle,
          "questions": remote,
        });
      } else if (remote is Map) {
        parsed = QuestionSet.fromJson(Map<String, dynamic>.from(remote));
      }
    }

    if (!mounted) return;

    if (parsed == null || parsed.questions.isEmpty) {
      setState(() {
        notice = "Failed to load questions.";
      });
      return;
    }

    setState(() {
      currentQuestionSet = parsed;
      notice = "";
    });
  }

  void _answer(bool selected) {
    final qs = currentQuestionSet!;
    final q = qs.questions[qIndex];

    if (answered.contains(q.id)) return;

    bool correct = (q.answer == selected);

    if (correct) score++;

    answered.add(q.id);

    userAnswers.add({
      "question": q.text,
      "correct_answer": q.answer ? "True" : "False",
      "selected_answer": selected ? "True" : "False",
      "is_correct": correct,
    });

    setState(() {});
  }

  void _next() {
    if (qIndex < currentQuestionSet!.questions.length - 1) {
      setState(() => qIndex++);
    } else {
      _gotoResult();
    }
  }

  void _previous() {
    if (qIndex > 0) {
      setState(() => qIndex--);
    }
  }

  void _jumpTo(int index) {
    setState(() => qIndex = index);
  }

  void _gotoResult() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Result(
          score: score,
          total: currentQuestionSet!.questions.length,
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
    bool already = answered.contains(q.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.quizTitle)),
      body: Row(
        children: [
          Container(
            width: 70,
            color: Colors.grey.shade50,
            child: ListView.builder(
              itemCount: qs.questions.length,
              itemBuilder: (context, i) {
                bool done = answered.contains(qs.questions[i].id);
                bool active = i == qIndex;

                Color color = Colors.white;
                Color textColor = Colors.black;

                if (active) {
                  color = Colors.blue;
                  textColor = Colors.white;
                } else if (done) {
                  color = Colors.green;
                  textColor = Colors.white;
                }

                return GestureDetector(
                  onTap: () => _jumpTo(i),
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Center(
                      child: Text(
                        "${i + 1}",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // -----------------------------------------
          // MAIN QUESTION AREA
          // -----------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${qIndex + 1} / ${qs.questions.length}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Divider(),

                  Text(q.text, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: already ? null : () => _answer(true),
                    child: const Text("True"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: already ? null : () => _answer(false),
                    child: const Text("False"),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: qIndex > 0 ? _previous : null,
                        child: const Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: _next,
                        child: const Text("Next"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
