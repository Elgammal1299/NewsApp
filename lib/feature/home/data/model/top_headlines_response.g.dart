// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_headlines_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesResponse _$TopHeadlinesResponseFromJson(
  Map<String, dynamic> json,
) => TopHeadlinesResponse(
  status: json['status'] as String,
  totalResults: (json['totalResults'] as num).toInt(),
  articles:
      (json['articles'] as List<dynamic>)
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TopHeadlinesResponseToJson(
  TopHeadlinesResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'totalResults': instance.totalResults,
  'articles': instance.articles.map((e) => e.toJson()).toList(),
};

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  source: SourceModel.fromJson(json['source'] as Map<String, dynamic>),
  author: json['author'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  url: json['url'] as String,
  urlToImage: json['urlToImage'] as String?,
  publishedAt: json['publishedAt'] as String,
  content: json['content'] as String?,
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) =>
    SourceModel(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
