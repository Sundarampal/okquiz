import 'package:flutter/material.dart';
class Forthquestion extends StatelessWidget {
  const Forthquestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Question"), centerTitle: true,),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/fifth');
        },
            child: Text("Next Result Page")),
      ),
    );
  }
}
