import 'package:flutter/material.dart';

import '../../components/components.dart';

class NamedRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Named Route'),
      ),
      drawer: JWFDDrawer(),
      body: Center(
        child: RaisedButton(
          child: Text('Go'),
          onPressed: () => Navigator.of(context).pushNamed('/back'),
        ),
      ),
    );
  }
}
