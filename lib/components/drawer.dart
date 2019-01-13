import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../pages/pages.dart';

class JWFDDrawer extends StatefulWidget {
  @override
  JWFDDrawerState createState() => JWFDDrawerState();
}

class JWFDDrawerState extends State<JWFDDrawer> {
  static var _packageInfo = PackageInfo();
  static var _isHome = true;
  static final _panels = [
    {
      'title': 'Layout',
      'isExpanded': false,
      'items': [
        {
          'title': 'Scaffold',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ScaffoldPage(),
        },
        {
          'title': 'Pavlova',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => PavlovaPage(),
        },
        {
          'title': 'Horizontal and Vertical Align',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HoriVertAlignPage(),
        },
        {
          'title': 'Horizontal and Vertical Sizing',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HoriVertSizingPage(),
        },
        {
          'title': 'Container',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ContainerPage(),
        },
        {
          'title': 'Grid View Extent',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => GridViewExtentPage(),
        },
        {
          'title': 'Grid View Count',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => GridViewCountPage(),
        },
        {
          'title': 'List View',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ListViewPage(),
        },
        {
          'title': 'Stack',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => StackPage(),
        },
        {
          'title': 'Card',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => CardPage(),
        },
        {
          'title': 'Lake',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => LakePage(),
        },
      ],
    },
    {
      'title': 'Navigation',
      'isExpanded': false,
      'items': [
        {
          'title': 'Basic',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => BasicNavigationPage(),
        },
        {
          'title': 'TabBar',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => TabBarNavigationPage(),
        },
        {
          'title': 'Send Data',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => SendDataPage(),
        },
        {
          'title': 'Return Data',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => ReturnDataPage(),
        },
        {
          'title': 'Named Route',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => NamedRoutePage(),
        },
        {
          'title': 'Hero',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => HeroPage(),
        },
        {
          'title': 'Nested',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => NestedNavigationPage(),
        },
      ],
    },
    {
      'title': 'Ineraction',
      'isExpanded': false,
      'items': [
        {
          'title': 'Favorite Lake',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => FavoriteLakePage(),
        },
        {
          'title': 'Refresh Indicator',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => RefreshIndicatorPage(),
        },
        {
          'title': 'Silver App Bar',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => SilverAppBarScrollPage(),
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
      child: ListView(
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
                .asMap()
                .map<int, ExpansionPanel>(
                  (index, panel) => MapEntry(
                        index,
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) => ListTile(
                                onTap: () =>
                                    _onExpand(index, panel['isExpanded']),
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
                              children: (panel['items']
                                      as List<Map<String, Object>>)
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
                      ),
                )
                .values
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
