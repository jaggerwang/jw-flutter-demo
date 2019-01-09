import 'package:flutter/material.dart';

import '../../components/components.dart';

class HoriVertSizingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal and Vertical Sizing'),
      ),
      drawer: JWFDDrawer(),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/small-pic-1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/small-pic-2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/small-pic-3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
