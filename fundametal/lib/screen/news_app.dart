/*
      27 Januari 2021
      Mengambil data dari berkas JSON lalu ditampilkan sebagai list.
      Mengimplementasikan named routes untuk navigasi halaman.
      Menambahkan packagewebview untuk menampilkan konten web.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/view/styles.dart';
import 'package:fundametal/widgets/article_list_page.dart';
import 'package:fundametal/widgets/platform_widget.dart';
import 'package:fundametal/widgets/settings_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: myTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(bodyColor: Colors.black),
          elevation: 0,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: secondaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
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

  void _onBottomNavTapped (int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: tabs[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
        ),
        tabBuilder: (context, index) {
          return tabs[index];
        },
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
          'News App',
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(
                    height: 200,
                    child: Icon(Icons.error),
                  )
                : Hero(
                    tag: article.urlToImage,
                    child: Image.network(article.urlToImage),
                  ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? "",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.title ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    'Date: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Author: ${article.author}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);
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
    label:  'Headline',
  ),
  BottomNavigationBarItem(
    icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
    label: 'Settings',
  ),
];
