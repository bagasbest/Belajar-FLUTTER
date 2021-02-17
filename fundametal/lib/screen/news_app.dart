/*
      27 Januari 2021
      Mengambil data dari berkas JSON lalu ditampilkan sebagai list.
      Mengimplementasikan named routes untuk navigasi halaman.
      Menambahkan packagewebview untuk menampilkan konten web.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundametal/common/navigation.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/provider/news_provider.dart';
import 'package:fundametal/provider/preferences_provider.dart';
import 'package:fundametal/provider/schduling_provider.dart';
import 'package:fundametal/screen/latihan_cupertino.dart';
import 'package:fundametal/service/api_service.dart';
import 'package:fundametal/utils/alarm_manager_background_service.dart';
import 'package:fundametal/utils/article_background_service.dart';
import 'package:fundametal/utils/article_notification_helper.dart';
import 'package:fundametal/view/styles.dart';
import 'bookmark_page.dart';
import 'file:///D:/TUBES_GALERI/Belajar-FLUTTER/fundametal/lib/screen/article_list_page.dart';
import 'package:fundametal/widgets/platform_widget.dart';
import 'file:///D:/TUBES_GALERI/Belajar-FLUTTER/fundametal/lib/screen/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'News App',
          theme: provider.themeData,
          builder: (context, child) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness:
                    provider.isDarkTheme ? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
          navigatorKey: navigatorKey,
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => HomePage(),
            ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                article: ModalRoute.of(context).settings.arguments),
            ArticleWebView.routeName: (context) => ArticleWebView(
                  url: ModalRoute.of(context).settings.arguments,
                ),
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = '/article_list';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArticleNotificationHelper _articleNotificationHelper =
      ArticleNotificationHelper();
  final ArticleBackgroundService _service = ArticleBackgroundService();

  int _bottomNavIndex = 0;

  final tabs = [
    ArticleListPage(),
    SettingsPages(),
    BookmarksPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    article_port.listen(
      (_) async => await _service.someTask(),
    );
    _articleNotificationHelper
        .configureSelectNotificationSubject(ArticleDetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
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
                      Navigation.intentWithData(
                          ArticleWebView.routeName, article.url);
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
    label: 'Headline',
  ),
  BottomNavigationBarItem(
    icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
    label: 'Settings',
  ),
  BottomNavigationBarItem(
    icon: Icon(Platform.isIOS
        ? CupertinoIcons.bookmark
        : Icons.collections_bookmark),
    label: 'Bookmarks',
  ),
];
