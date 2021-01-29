import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article.dart';
import 'package:fundametal/screen/news_app.dart';

class ArticleListPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Kamu mau makan/minum apa ?',
            border: InputBorder.none,
            icon: IconButton(
              icon: Icon(CupertinoIcons.search),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Coming Soon :)'),
                      content: Text(
                          'This feature will be developed soon!'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _buildList(context),
        )

      ],
    );

  }
}

FutureBuilder<String> _buildList(BuildContext context) {
  return FutureBuilder(
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
  );
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
