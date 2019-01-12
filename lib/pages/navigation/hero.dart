import 'package:flutter/material.dart';

import '../../components/components.dart';

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero'),
      ),
      drawer: JWFDDrawer(),
      body: GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Image.asset('assets/images/lake.jpg'),
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
              return _DetailPage();
            })),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.asset('assets/images/lake.jpg'),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
