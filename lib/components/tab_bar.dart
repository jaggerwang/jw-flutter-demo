import 'package:flutter/material.dart';

import '../pages/pages.dart';

class JWTabBar extends StatelessWidget {
  static final tabs = [
    {
      'title': Text('First'),
      'icon': Icon(Icons.home),
      'builder': (BuildContext context) => FirstTabPage(),
    },
    {
      'title': Text('Second'),
      'icon': Icon(Icons.add),
      'builder': (BuildContext context) => SecondTabPage(),
    },
    {
      'title': Text('Third'),
      'icon': Icon(Icons.account_circle),
      'builder': (BuildContext context) => ThirdTabPage(),
    },
  ];

  final int currentIndex;

  JWTabBar({
    Key key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          TabPage.globalKey.currentState.switchTab(index);
        }
      },
      items: tabs
          .map<BottomNavigationBarItem>(
            (v) => BottomNavigationBarItem(
                  icon: v['icon'],
                  title: v['title'],
                ),
          )
          .toList(),
    );
  }
}
