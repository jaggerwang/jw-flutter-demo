import 'package:flutter/material.dart';

import 'pages/pages.dart';

class JWApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JW Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        '/back': (context) => BackPage(),
      },
      home: HomePage(),
    );
  }
}

void main() => runApp(JWApp());
