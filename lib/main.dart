import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:okquiz/fifthresult.dart';
import 'package:okquiz/first.dart';
import 'package:okquiz/forthquestion.dart';
import 'package:okquiz/secondsbj.dart';
import 'package:okquiz/threequiz.dart';
void main () async{
String url = "https://sundarampal.github.io/myjsonfiles/newspaper.json";
final response = await http.get (Uri.parse(url));
News.showNewspaper(response.body);
print("hh");
print(response.statusCode);
// print(response.body);
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => First(),
      '/second':(context) => Secondsbj(),
      '/third':(context) => Threequiz(),
      '/forth':(context) => Forthquestion(),
      '/fifth':(context) => Fifthresult(),
    }
  ));
}




