import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PackageInfo _packageInfo = PackageInfo();

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        _packageInfo = packageInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Text(
                  'JW Flutter Demo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pop(),
              title: Text('CustomScrollView'),
            ),
            Divider(),
            AboutListTile(
              applicationName: _packageInfo.appName,
              applicationLegalese: 'Copyright © Jagger Wang',
              applicationVersion: _packageInfo.version,
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'JW Flutter Demo',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
