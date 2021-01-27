/*
      27 Januari 2021
      Mengambil data dari berkas JSON lalu ditampilkan sebagai list.
      Mengimplementasikan named routes untuk navigasi halaman.
      Menambahkan packagewebview untuk menampilkan konten web.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article.dart';
import 'package:fundametal/view/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
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

class NewListPage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        textTheme: myTextTheme.apply(bodyColor: Colors.black),
        elevation: 0,
      ),
      body: FutureBuilder(
        ///DefaultAssetBundle pada dasarnya juga merupakan sebuah widget. Widget ini akan membaca String dari berkas aset yang kita tentukan.
        future:
            DefaultAssetBundle.of(context).loadString('assets/articles.json'),
        builder: (context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data);
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, articles[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return Material(
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Hero(
        tag: article.urlToImage,
        child: Image.network(
          article.urlToImage,
          width: 100,
        ),
      ),
      title: Text(
        article.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(article.author),
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article);
      },
    ),
  );
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
