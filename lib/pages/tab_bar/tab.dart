import 'package:flutter/material.dart';

import '../../components/components.dart';

class TabPage extends StatefulWidget {
  static final globalKey = GlobalKey<_TabPageState>();

  TabPage() : super(key: globalKey);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final _navigatorKeys = JWTabBar.tabs
      .map<GlobalKey<NavigatorState>>((v) => GlobalKey<NavigatorState>())
      .toList();
  final _focusScopeNodes =
      JWTabBar.tabs.map<FocusScopeNode>((v) => FocusScopeNode()).toList();
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
        children: JWTabBar.tabs
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
