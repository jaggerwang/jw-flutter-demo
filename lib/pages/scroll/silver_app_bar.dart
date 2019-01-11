import 'package:flutter/material.dart';

import '../../components/components.dart';

class SilverAppBarScrollPage extends StatelessWidget {
  static final _tabs = ['Tab1', 'Tab2', 'Tab3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: JWFDDrawer(),
      body: DefaultTabController(
        length: _tabs.length,
        child: _Body(
          tabs: _tabs,
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<String> tabs;

  _Body({
    Key key,
    @required this.tabs,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _items = {
    'Tab1': <String>[],
    'Tab2': <String>[],
    'Tab3': <String>[],
  };
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    _loadItems(widget.tabs[0]);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _scrollListener() {
    print(
        'scroll position: ${_scrollController.position.pixels} ${_scrollController.position.maxScrollExtent}');
    final index = DefaultTabController.of(context).index;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadItems(widget.tabs[index]);
    }
  }

  void _loadItems(String name) {
    print('load items for $name');
    setState(() {
      final start = _items[name].length;
      _items[name]
          .addAll(List<String>.generate(20, (i) => 'Item ${start + i}'));
      print(_items[name]);
    });
  }

  Widget _buildSilverAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
        title: const Text('Silver App Bar'),
        expandedHeight: 150,
        forceElevated: innerBoxIsScrolled,
        bottom: TabBar(
          tabs: widget.tabs.map((String name) => Tab(text: name)).toList(),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: widget.tabs.map<Widget>((name) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (context) => CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            ListTile(title: Text('$name Item $index')),
                        childCount: _items[name].length,
                      ),
                    ),
                  ],
                ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
            _buildSilverAppBar(context, innerBoxIsScrolled),
          ],
      body: _buildTabBarView(),
    );
  }
}
