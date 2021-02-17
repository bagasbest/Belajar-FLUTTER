import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/common/navigation.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/provider/database_article_provider.dart';
import 'package:fundametal/provider/preferences_provider.dart';
import 'package:fundametal/screen/news_app.dart';
import 'package:fundametal/view/styles.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  CardArticle({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseArticleProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: article.urlToImage == null
                    ? Container(width: 100, child: Icon(Icons.error))
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
                trailing: isBookmarked
                    ? IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () => provider.removeBookmark(article.url),
                )
                    : IconButton(
                  icon: Icon(Icons.bookmark_border),
                  onPressed: () => provider.addBookmarks(article),
                ),
                onTap: () => Navigation.intentWithData(
                    ArticleDetailPage.routeName, article),
              ),
            );
          },
        );
      },
    );
  }
}
