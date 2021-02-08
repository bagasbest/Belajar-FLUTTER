import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/common/navigation.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/screen/news_app.dart';
import 'package:fundametal/view/styles.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  CardArticle({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: article.urlToImage == null
            ? Container(
          width: 100,
          child: Icon(Icons.error),
        )
            : Hero(
          tag: article.urlToImage,
          child: Image.network(
            article.urlToImage,
            width: 100,
          ),
        ),
        title: Text(
          article.title ?? "",
        ),
        subtitle: Text(article.author ?? ""),
        onTap: () {
          Navigation.intentWithData(ArticleDetailPage.routeName, article);
        },
      ),
    );
  }
}
