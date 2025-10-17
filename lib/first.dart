import 'package:flutter/material.dart';
class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}
class _FirstState extends State<First> {
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Startup Screen"), centerTitle: true,),
        body: Center(
          child: ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
              child: Text("subjects Page")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
