
import 'package:flutter/foundation.dart';
import 'package:fundametal/helper/database_article_helper.dart';
import 'package:fundametal/model/article_new.dart';
import 'package:fundametal/utils/result_state.dart';

class DatabaseArticleProvider extends ChangeNotifier {
  final DatabaseArticleHelper databaseArticleHelper;

  DatabaseArticleProvider({@required this.databaseArticleHelper}){
    _getBookmarks();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message;
  String get message => _message;

  List <Article> _bookmarks = [];
  List <Article> get bookmarks => _bookmarks;
  
  void _getBookmarks() async {
    _bookmarks = await databaseArticleHelper.getBookmarks();
    if(_bookmarks.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }
  
  void addBookmarks (Article article) async {
    try  {
      await databaseArticleHelper.insertBookmark(article);
      _getBookmarks();
    } catch (err) {
      _state = ResultState.Error;
      _message = 'Error: $err';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await databaseArticleHelper.getBookmarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseArticleHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }



}