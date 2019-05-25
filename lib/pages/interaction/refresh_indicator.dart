import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/components.dart';

class RefreshIndicatorPage extends StatefulWidget {
  @override
  _RefreshIndicatorPageState createState() => _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  final _controller = ScrollController();

  Future<Null> _refresh() {
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(100, (i) => i + 1).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh Indicator'),
      ),
      drawer: JWFDDrawer(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
                title: Text('Item ${items[index]}'),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.animateTo(
              0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            ),
        child: Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}
