import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/provider/news_provider.dart';
import 'package:fundametal/service/api_service.dart';
import 'package:fundametal/widgets/card_article.dart';
import 'package:fundametal/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

// class ArticleListPage extends StatefulWidget {
//   @override
//   _ArticleListPageState createState() => _ArticleListPageState();
// }
//
// class _ArticleListPageState extends State<ArticleListPage> {
//   Future<ArticleResult> _article;
//
//   @override
//   void initState() {
//     _article = ApiService().topHeadlines();
//     super.initState();
//   }
//
//   Widget _buildList(BuildContext context) {
//     return FutureBuilder(
//       future: _article,
//       builder: (context, AsyncSnapshot<ArticleResult> snapshot) {
//         var state = snapshot.connectionState;
//         if (state != ConnectionState.done) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.articles.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 var article = snapshot.data.articles[index];
//                 return CardArticle(
//                   article: article,
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 snapshot.error.toString(),
//               ),
//             );
//           } else {
//             return Text('');
//           }
//         }
//       },
//     );
//   }

class ArticleListPage extends StatelessWidget {
  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: state.result.articles.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(
                article: article,
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
