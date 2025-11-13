import 'forthquestion.dart';

class QuestionSet {
  final String id;
  final String title;
  final List<Question> questions;

  QuestionSet({required this.id, required this.title, required this.questions});

  factory QuestionSet.fromJson(Map<String, dynamic> j) {
    final qs = <Question>[];
    if (j['questions'] is List) {
      for (final e in j['questions']) {
        qs.add(Question.fromJson(Map<String, dynamic>.from(e)));
      }
    }
    return QuestionSet(
      id: j['id'] ?? j['quiz_id'] ?? 'quiz',
      title: j['title'] ?? '',
      questions: qs,
    );
  }
}
