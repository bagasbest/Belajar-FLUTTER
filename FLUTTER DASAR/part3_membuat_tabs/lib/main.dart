import 'package:flutter/material.dart';
import './home.dart';
import './news.dart';
import './popular.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // Membuat tabController
  // Code baru
  TabController mTabController;

  @override
  void initState() {
    super.initState();
    //LENGTH = TOTAL TAB YANG AKAN DIBUAT
    mTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    mTabController.dispose();
    super.dispose();
  }

  // Akhir code baru

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          leading: Icon(Icons.tab),
          title: Text("Belajar Membuat Tabs"),

          // Tambahkan TabBar widget untuk menampilkan tab yang diinginkan
          bottom: TabBar(
            controller: mTabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                child: Text("Home"),
              ),
              Tab(
                icon: Icon(Icons.note),
                child: Text("Popular"),
              ),
              Tab(
                icon: Icon(Icons.poll),
                child: Text("News"),
              ),
            ],
          ),
        ),

        // Code baru
        body: TabBarView(
            controller: mTabController,
            children: <Widget>[Home(), Popular(), News()]),
      ),
    );
  }
}
