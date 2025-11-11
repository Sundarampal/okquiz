class Question {
  final String id;
  final String text;
  final bool answer;

  Question({required this.id, required this.text, required this.answer});

  factory Question.fromJson(Map<String, dynamic> j) {
    final raw = j['answer'];
    bool ans;
    if (raw is bool) {
      ans = raw;
    } else if (raw is String) {
      ans = raw.toLowerCase() == 'true';
    } else {
      ans = false;
    }
    return Question(
      id: j['id'] ?? '',
      text: j['text'] ?? j['question'] ?? '',
      answer: ans,
    );
  }
}
