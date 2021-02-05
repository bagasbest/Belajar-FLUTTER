import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/service/api_service.dart';
import 'package:fundametal/widgets/card_article.dart';
import 'package:fundametal/widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  Future<ArticleResult> _article;

  @override
  void initState() {
    _article = ApiService().topHeadlines();
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _article,
      builder: (context, AsyncSnapshot<ArticleResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.articles.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var article = snapshot.data.articles[index];
                return CardArticle(
                  article: article,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return Text('');
          }
        }
      },
    );
  }

  Widget _buildAndroid (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos (BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget build (BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }


}

