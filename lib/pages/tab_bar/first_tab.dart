import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';

class FirstTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 3),
          RaisedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BackPage(),
                )),
            child: Text('Go'),
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: JWTabBar(currentIndex: 0),
    );
  }
}
