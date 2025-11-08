import 'package:flutter/material.dart';
class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"), centerTitle: true,),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
            child: Text("Next Page")),
      ),
    );
  }
}
