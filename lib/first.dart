import 'dart:convert' as convert;

import 'package:flutter/material.dart';

class News {
  static void showNewspaper(var news) {
    var data = convert.jsonDecode(news);
    int n = data.length;
    print(n);
    widgets.clear();
    print(news);
    for (int i = 0; i <= n - 1; i++) {
      widgets.add(Text(data[i]["id"]));
      widgets.add(Text(data[i]["title"]));
      widgets.add(Text(data[i]["summary"]));
      widgets.add(Text(data[i]["details"]));
      print(data[i]["title"]);
    }
  }

  static List<Widget> widgets = [];
}

class First extends StatefulWidget {
  First({super.key});

  var widgets = [
    Text("this cant station market is closed"),
    Text("Two"),
    Text("three"),
  ];
  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Startup Screen"), centerTitle: true),
      body: Column(children: News.widgets),
    );
  }
}

