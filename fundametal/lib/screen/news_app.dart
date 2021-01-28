/*
      27 Januari 2021
      Mengambil data dari berkas JSON lalu ditampilkan sebagai list.
      Mengimplementasikan named routes untuk navigasi halaman.
      Menambahkan packagewebview untuk menampilkan konten web.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article.dart';
import 'package:fundametal/view/styles.dart';
import 'package:fundametal/widgets/article_list_page.dart';
import 'package:fundametal/widgets/platform_widget.dart';
import 'package:fundametal/widgets/settings_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'latihan_cupertino.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          buttonTheme: ButtonThemeData(
              buttonColor: secondaryColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
          )),
      initialRoute: NewListPage.routeName,
      routes: {
        NewListPage.routeName: (context) => NewListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
            article: ModalRoute.of(context).settings.arguments),
        ArticleWebView.routeName: (context) => ArticleWebView(
              url: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}

class NewListPage extends StatefulWidget {
  static const routeName = '/article_list';

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  int _bottomNavIndex = 0;

  final tabs = [
    ArticleListPage(),
    SettingsPages(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_bottomNavIndex == 0) ? 'News App' : 'Settings'),
        textTheme: myTextTheme.apply(bodyColor: Colors.black),
        elevation: 0,
      ),
      body: tabs[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
        ),
        tabBuilder: (context, index) {
          return tabs[_bottomNavIndex];
        },
      ),
    );
  }
}



///Buat berkas baru bernama detail_page.dart yang berisi kode untuk berperan sebagai detail dari news app list
class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage,
              child: Image.network(article.urlToImage),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);
                      print("Url: ${article.url}");
                    },
                    child: Text('Read more'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  ArticleWebView({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}

List<BottomNavigationBarItem> _bottomNavBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
    title: Text('Headline'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
    title: Text('Settings'),
  ),
];