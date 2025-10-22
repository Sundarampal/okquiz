import 'package:flutter/material.dart';
class First extends StatefulWidget {
    First({super.key});
var widgets=[Text("One"), Text("Two"), Text("three")];
  @override
  State<First> createState() => _FirstState();
}
class _FirstState extends State<First> {
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Startup Screen"), centerTitle: true,),
        body: Column(
          children: widget.widgets


        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
