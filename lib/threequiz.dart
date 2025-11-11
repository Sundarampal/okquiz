import 'package:flutter/material.dart';
import 'package:okquiz/play.dart';
import 'package:okquiz/utilitiesdart.dart';
class Quiz extends StatefulWidget {
  final String subjectId;
  final String subjectName;
  final String quizzesUrl;

  const Quiz({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.quizzesUrl,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<dynamic> quizzes = [];
  String notice = 'Loading quizzes...';

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final qRemote = await Utilities.downloadJson(widget.quizzesUrl);
    if (!mounted) return;
    setState(() {
      quizzes = qRemote is List ? qRemote : [];
      notice = quizzes.isEmpty ? 'Failed to load quizzes.' : '';
    });
  }

  void _startQuiz(
      BuildContext context,
      String id,
      String title,
      String questionsUrl,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Play(
          quizId: id,
          quizTitle: title,
          questionsUrl: questionsUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizCards =
    Utilities.quizWidgets(quizzes, (id, title, url) => _startQuiz(context, id, title, url));

    return Scaffold(
      appBar: AppBar(title: Text('Quizzes • ${widget.subjectName}')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: notice.isNotEmpty
            ? Center(child: Text(notice))
            : ListView(children: quizCards),
      ),
    );
  }
}
