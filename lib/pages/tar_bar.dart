import 'package:flutter/material.dart';

import '../components/components.dart';
import 'pages.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar'),
      ),
      drawer: JWFDDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 3),
            RaisedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TabPage(),
                  )),
              child: Text('Show Tabs'),
            ),
            Spacer(),
            Text(
                'Use BottomNavigationBar to display tabs, and Stack to keep each tab\'s state when switching between tabs.'),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
