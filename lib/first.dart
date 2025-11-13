import 'package:flutter/material.dart';
import 'package:okquiz/subject.dart';
import 'package:okquiz/utilitiesdart.dart';

class First extends StatefulWidget {
  const First({super.key});
  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  List<dynamic> news = [];
  List<dynamic> subjects = [];
  String notice = 'Loading news...';

  @override
  void initState() {
    super.initState();
    _loadNewsThenSubjects();
  }

  Future<void> _loadNewsThenSubjects() async {
    final nRemote = await Utilities.downloadJson(
      'https://sundarampal.github.io/myjsonfiles/newspaper.json',
    );

    if (!mounted) return;
    setState(() {
      news = nRemote is List ? nRemote : [];
      notice = news.isEmpty ? 'Failed to load news.' : 'Loading subjects...';
    });

    final sRemote = await Utilities.downloadJson(
      'https://sundarampal.github.io/myjsonfiles/subject1_2.json',
    );

    if (!mounted) return;
    setState(() {
      subjects = sRemote is List ? sRemote : [];
      if (subjects.isEmpty) {
        notice = 'Failed to load subjects.';
      } else {
        notice = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsWidgets = Utilities.newsWidgets(news, context);

    return Scaffold(
      appBar: AppBar(title: const Text('Start News'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Only News',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (notice.isNotEmpty) Text(notice),
            Expanded(
              child: ListView(
                children: [
                  ...newsWidgets,
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: subjects.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Subject(subjects: subjects, subjecs: null,),
                        ),
                      );
                    },
                    child: const Text('View Subjects'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
