import 'package:json_annotation/json_annotation.dart';

part 'top_headlines_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TopHeadlinesResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  TopHeadlinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory TopHeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesResponseToJson(this);
}

@JsonSerializable()
class ArticleModel {
  final SourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  ArticleModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String? name;

  SourceModel({this.id, this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
