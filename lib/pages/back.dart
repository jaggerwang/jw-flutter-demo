import 'package:flutter/material.dart';

class BackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Back'),
        ),
      ),
    );
  }
}
