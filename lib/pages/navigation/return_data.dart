import 'package:flutter/material.dart';

import '../../components/components.dart';

class ReturnDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Data'),
      ),
      drawer: JWFDDrawer(),
      body: Center(child: _SelectionButton()),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _SelectionPage()),
        );

        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$result')));
      },
      child: Text('Pick an option, any option!'),
    );
  }
}

class _SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () => Navigator.pop(context, 'Yep!'),
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () => Navigator.pop(context, 'Nope.'),
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
