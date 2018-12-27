import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../pages/pages.dart';

class JWDrawer extends StatefulWidget {
  @override
  JWDrawerState createState() => JWDrawerState();
}

class JWDrawerState extends State<JWDrawer> {
  static var _packageInfo = PackageInfo();
  static var _isHome = true;
  static final _panels = [
    {
      'title': 'Navigation',
      'isExpanded': false,
      'items': [
        {
          'title': 'TabBar',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => TabBarPage(),
        },
      ],
    },
    {
      'title': 'Scroll',
      'isExpanded': false,
      'items': [
        {
          'title': 'ListView',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ListViewPage(),
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        _packageInfo = packageInfo;
      });
    });
  }

  void _resetPanels() {
    _panels.forEach((panel) {
      panel['isExpanded'] = false;
      (panel['items'] as List<Map<String, Object>>).forEach((item) {
        item['isSelected'] = false;
      });
    });
  }

  void _goHome() {
    _isHome = true;

    _resetPanels();

    Navigator.of(context)
      ..pop()
      ..pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
  }

  void _onExpand(index, isExpanded) {
    _resetPanels();

    _panels[index]['isExpanded'] = !isExpanded;

    setState(() {});
  }

  void _onSelected(Map<String, Object> panel, Map<String, Object> item) {
    _isHome = false;

    _resetPanels();

    panel['isExpanded'] = true;
    item['isSelected'] = true;

    Navigator.of(context)
      ..pop()
      ..pushReplacement(MaterialPageRoute(
        builder: item['pageBuilder'],
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Center(
              child: Text(
                'JW Flutter Demo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            onTap: _goHome,
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            selected: _isHome,
            dense: true,
          ),
          ExpansionPanelList(
            expansionCallback: _onExpand,
            children: _panels
                .map<ExpansionPanel>(
                  (panel) => ExpansionPanel(
                        headerBuilder: (context, isExpanded) => ListTile(
                              title: Text(
                                panel['title'],
                                style: TextStyle(fontSize: 16),
                              ),
                              selected: isExpanded,
                              dense: true,
                            ),
                        body: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children:
                                (panel['items'] as List<Map<String, Object>>)
                                    .map<Widget>((item) => ListTile(
                                          onTap: () => _onSelected(panel, item),
                                          title: Text(item['title']),
                                          selected: item['isSelected'],
                                          dense: true,
                                          enabled: item['pageBuilder'] != null,
                                        ))
                                    .toList(),
                          ),
                        ),
                        isExpanded: panel['isExpanded'],
                      ),
                )
                .toList(),
          ),
          Divider(),
          AboutListTile(
            applicationName: _packageInfo.appName,
            applicationLegalese: 'Copyright © Jagger Wang',
            applicationVersion: _packageInfo.version,
          ),
        ],
      ),
    );
  }
}
