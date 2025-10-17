import 'package:flutter/material.dart';
import 'package:okquiz/fifthresult.dart';
import 'package:okquiz/first.dart';
import 'package:okquiz/forthquestion.dart';
import 'package:okquiz/secondsbj.dart';
import 'package:okquiz/threequiz.dart';
void main (){
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




