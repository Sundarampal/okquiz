import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Utilities {
static Future<dynamic> downloadJson(String url) async {
try {
final resp = await http.get(Uri.parse(url));
if (resp.statusCode == 200) return json.decode(resp.body);
} catch (_) {}
return null;
}

static List<Widget> newsWidgets(List<dynamic> newsJson, BuildContext context) {
return newsJson.map<Widget>((n) {
final title = n['title'] ?? '';
final summary = n['summary'] ?? '';
final details = n['details'] ?? '';
return Card(
color: Colors.white,
shadowColor: Colors.green.shade100,
child: ListTile(
title: Text(title, style: const TextStyle(color: Colors.green)),
subtitle: Text(summary),
trailing: TextButton(
child: const Text('Details', style: TextStyle(color: Colors.green)),
onPressed: () {
showDialog(
context: context,
builder: (_) => AlertDialog(
backgroundColor: const Color(0xFFF3E8FF),
title: Text(title, style: const TextStyle(color: Colors.green)),
content: Text(details),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: const Text('Close', style: TextStyle(color: Colors.green)),
),
],
),
);
},
),
),
);
}).toList();
}

static List<Widget> subjectWidgets(
List<dynamic> subjectsJson,
void Function(String id, String name, String quizzesUrl) onTap,
) {
return subjectsJson.map<Widget>((s) {
final id = s['id'] ?? '';
final name = s['name'] ?? s['title'] ?? '';
final quizzesUrl = s['quizzes_url'] ?? s['quizzesUrl'] ?? '';
return Padding(
padding: const EdgeInsets.symmetric(vertical: 6),
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.green,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 14),
),
onPressed: quizzesUrl.isEmpty ? null : () => onTap(id, name, quizzesUrl),
child: Text(name, style: const TextStyle(fontSize: 16)),
),
);
}).toList();
}

static List<Widget> quizWidgets(
List<dynamic> quizzesJson,
void Function(String id, String title, String questionsUrl) onStart,
) {
return quizzesJson.map<Widget>((q) {
final id = q['id'] ?? '';
final title = q['title'] ?? '';
final desc = q['description'] ?? '';
final questionsUrl = q['questions_url'] ?? q['questionsUrl'] ?? '';
return Card(
color: Colors.white,
shadowColor: Colors.green.shade100,
child: ListTile(
title: Text(title, style: const TextStyle(color: Colors.green)),
subtitle: Text(desc),
trailing: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.green,
foregroundColor: Colors.white,
),
onPressed: questionsUrl.isEmpty
? null
    : () => onStart(id, title, questionsUrl),
child: const Text('Start'),
),
),
);
}).toList();
}
}
