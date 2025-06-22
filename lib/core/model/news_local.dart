import 'package:news_app/core/model/news_api_response.dart';

class NewsLocal {
  final int? id;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final String? author;
  final String? sourceName; // جاية من source.name في ArticleModel

  NewsLocal({
    this.id,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.author,
    this.sourceName,
  });

  /// لتحويل ArticleModel الجاي من الـ API إلى News
  factory NewsLocal.fromArticleModel(ArticleModel article) {
    return NewsLocal(
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      author: article.author,
      sourceName: article.source.name,
    );
  }

  /// لتحويل الكائن إلى Map لتخزينه في SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'author': author,
      'sourceName': sourceName,
    };
  }

  /// لتحويل Map إلى كائن Dart
  factory NewsLocal.fromMap(Map<String, dynamic> map) {
    return NewsLocal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
      author: map['author'],
      sourceName: map['sourceName'],
    );
  }
}
