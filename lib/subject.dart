import 'package:flutter/material.dart';
class second extends StatelessWidget {
  const second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subject"), centerTitle: true,),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/third');
        },
            child: Text("Next Page")),
      ),
    );
  }
}
