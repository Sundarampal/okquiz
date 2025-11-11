import 'package:flutter/material.dart';
import 'package:okquiz/first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const First(),
      debugShowCheckedModeBanner: false,
    );
  }
}
