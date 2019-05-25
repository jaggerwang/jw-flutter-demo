import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/components.dart';

class TabBarNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Navigation'),
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
                    builder: (context) => _TabBarPage(),
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

class _TabBarPage extends StatefulWidget {
  static final globalKey = GlobalKey<_TabBarPageState>();

  _TabBarPage() : super(key: globalKey);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<_TabBarPage> {
  final _navigatorKeys = _JWTabBar.tabs
      .map<GlobalKey<NavigatorState>>((v) => GlobalKey<NavigatorState>())
      .toList();
  final _focusScopeNodes =
      _JWTabBar.tabs.map<FocusScopeNode>((v) => FocusScopeNode()).toList();
  var _index = 0;

  void switchTab(int index) {
    setState(() {
      _index = index;
    });

    // FixBug: Offstage widget not auto loose focus.
    FocusScope.of(context).setFirstFocus(_focusScopeNodes[index]);
  }

  // Make sure not pop root navigator's route if nested navigator can pop
  // when press back button on Android.
  Future<bool> _onWillPop() async {
    final maybePop = await _navigatorKeys[_index].currentState.maybePop();
    return Future.value(!maybePop);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: IndexedStack(
        index: _index,
        children: _JWTabBar.tabs
            .asMap()
            .entries
            .map<Widget>(
              (entry) => FocusScope(
                    node: _focusScopeNodes[entry.key],
                    child: Navigator(
                      key: _navigatorKeys[entry.key],
                      onGenerateRoute: (settings) {
                        WidgetBuilder builder;
                        switch (settings.name) {
                          case '/':
                            builder = entry.value['builder'];
                            break;
                          default:
                            throw Exception('Invalid route: ${settings.name}');
                        }
                        return MaterialPageRoute(
                          builder: builder,
                          settings: settings,
                        );
                      },
                    ),
                  ),
            )
            .toList(),
      ),
    );
  }
}

class _JWTabBar extends StatelessWidget {
  static final tabs = [
    {
      'title': Text('First'),
      'icon': Icon(Icons.home),
      'builder': (BuildContext context) => _FirstTabPage(),
    },
    {
      'title': Text('Second'),
      'icon': Icon(Icons.add),
      'builder': (BuildContext context) => _SecondTabPage(),
    },
    {
      'title': Text('Third'),
      'icon': Icon(Icons.account_circle),
      'builder': (BuildContext context) => _ThirdTabPage(),
    },
  ];

  final int currentIndex;

  _JWTabBar({
    Key key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          _TabBarPage.globalKey.currentState.switchTab(index);
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

class _FirstTabPage extends StatelessWidget {
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
                  builder: (context) => _BackPage(),
                )),
            child: Text('Go'),
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _JWTabBar(currentIndex: 0),
    );
  }
}

class _SecondTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 3),
          RaisedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _BackPage(),
                )),
            child: Text('Go'),
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _JWTabBar(currentIndex: 1),
    );
  }
}

class _ThirdTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 3),
          RaisedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _BackPage(),
                )),
            child: Text('Go'),
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _JWTabBar(currentIndex: 2),
    );
  }
}

class _BackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
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
