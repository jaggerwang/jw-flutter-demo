import 'package:flutter/material.dart';

import '../components/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: JWDrawer(),
      body: Center(
        child: Text(
          'JW Flutter Demo',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
