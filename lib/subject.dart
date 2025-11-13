import 'package:flutter/material.dart';
import 'package:okquiz/threequiz.dart';
import 'package:okquiz/utilitiesdart.dart';
class Subject extends StatelessWidget {
  final List<dynamic> subjects;

  const Subject({
    super.key,
    required this.subjects, required subjecs,
  });

  void _openQuizzesFor(
      BuildContext context, String id, String name, String quizzesUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Quiz(
          subjectId: id,
          subjectName: name,
          quizzesUrl: quizzesUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectButtons = Utilities.subjectWidgets(
      subjects,
          (id, name, quizzesUrl) => _openQuizzesFor(context, id, name, quizzesUrl),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(children: subjectButtons),
      ),
    );
  }
}
