import 'package:flutter/material.dart';

class ScaffoldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Scaffold'),
      ),
      body: Center(
        child: Text('Hello Dart!'),
      ),
    );
  }
}
