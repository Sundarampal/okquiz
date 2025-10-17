import 'package:flutter/material.dart';
class Threequiz extends StatelessWidget {
  const Threequiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Page"), centerTitle: true,),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/forth');
        },
            child: Text("Next Question Page")),
      ),
    );
  }
}
