import 'package:flutter/material.dart';

import '../../components/components.dart';

class ScaffoldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Scaffold'),
      ),
      drawer: JWFDDrawer(),
      body: Center(
        child: Text('Hello Dart!'),
      ),
    );
  }
}
