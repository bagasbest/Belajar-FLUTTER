import 'dart:convert';

import 'package:fundametal/model/article_new.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '1039a7eb7c0e4dc3acb5252ac42853bf';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticleResult> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");

    if (response.statusCode == 200) {
      return ArticleResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headline');
    }
  }
}
