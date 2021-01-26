import 'dart:convert';

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ///Tambahkan named constructor untuk mengonversi format JSON menjadi bentuk objek Article.
  Article.fromJson(Map<String, dynamic> article) {
    author = article['author'];
    title = article['description'];
    description = article['description'];
    url = article['url'];
    urlToImage = article['urlToImage'];
    publishedAt = article['publishedAt'];
    content = article['content'];
  }
}

/*
 Karena Future kita mengembalikan String,
 maka kita perlu mengonversinya menjadi objek yang kita siapkan.
 Proses konversi ini juga dikenal dengan json parsing.
 Mari buat fungsi baru di dalam berkas article.dart.
*/
List<Article> parseArticles(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Article.fromJson(json)).toList();
}
