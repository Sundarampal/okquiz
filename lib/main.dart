import 'package:flutter/material.dart';
import 'package:okquiz/fifthresult.dart';
import 'package:okquiz/first.dart';
import 'package:okquiz/forthquestion.dart';
import 'package:okquiz/subject.dart';
import 'package:okquiz/threequiz.dart';
import 'package:okquiz/utilitiesdart.dart';

void main() async{
  String url = "https://sundarampal.github.io/myjsonfiles/newspaper.json";
  final response = await Utilities.downloadjson(url);


  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => First(),
        '/second': (context) => second(),
        '/third': (context) => Threequiz(),
        '/forth': (context) => Forthquestion(),
        '/fifth': (context) => Fifthresult(),
      },
    ),
  );
}
