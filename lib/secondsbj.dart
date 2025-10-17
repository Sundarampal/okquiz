import 'package:flutter/material.dart';
class Secondsbj extends StatelessWidget {
  const Secondsbj({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Subjects Page"),centerTitle: true),
        body: Center(
          child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/third');
          }, child:Text("Quiz Page") ),
        ),
      ),
    );
  }
}
