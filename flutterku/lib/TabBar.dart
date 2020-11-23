import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(
      //indicatorColor: Colors.redAccent,
      indicator: BoxDecoration(
          color: Colors.amber,
          border: Border(
              top: BorderSide(
            color: Colors.orange,
          ))),
      tabs: [
        Tab(
          icon: Icon(Icons.comment),
          text: 'Comments',
        ),
        Tab(
          child: Image(
            image: AssetImage('lib/assets/tw.png'),
          ),
        ),
        Tab(
          icon: Icon(Icons.computer),
        ),
        Tab(
          text: 'News',
        )
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('AppBar'),
            backgroundColor: Colors.amber,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
              child: Container(color: Colors.orange, child: myTabBar),
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text('Tab 1'),
              ),
              Center(
                child: Text('Tab 2'),
              ),
              Center(
                child: Text('Tab 3'),
              ),
              Center(
                child: Text('Tab 4'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
