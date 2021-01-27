import 'package:flutter/material.dart';
import 'package:fundametal/data/academy_data.dart';
import 'package:fundametal/model/academy.dart';

class SliverListAndGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicoding Learning Paths'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        leading: Icon(Icons.menu),
      ),
      body: LearningPathList(),
    );
  }
}

class LearningPathList extends StatelessWidget {
  SliverPersistentHeader _header(String text) {
    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(
          minHeight: 60,
          maxHeight: 150,
          child: Container(
            color: Colors.pinkAccent,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
      pinned: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _header('Android Developer'),
        SliverList(
          delegate: SliverChildListDelegate(
            androidPaths.map(_buildTile).toList(),
          ),
        ),
        _header('IOS Developer'),
        SliverList(
          delegate: SliverChildListDelegate(
            iosPaths.map(_buildTile).toList(),
          ),
        ),
        _header('Multi-Platform App Developer'),
        SliverGrid.count(
          crossAxisCount: 2,
          children: flutterPaths.map(_buildTile).toList(),
        ),
        _header('Front-End Web Developer'),
        SliverList(
          delegate: SliverChildListDelegate(
            webPaths.map(_buildTile).toList(),
          ),
        ),
      ],
    );
  }
}

Widget _buildTile(Academy academy) {
  return ListTile(
    title: Text(academy.title),
    subtitle: Text(academy.description),
  );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
