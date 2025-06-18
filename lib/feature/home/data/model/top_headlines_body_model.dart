import 'package:json_annotation/json_annotation.dart';
part 'top_headlines_body_model.g.dart';

@JsonSerializable()
class TopHeadlinesBodyModel {
  final String country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  TopHeadlinesBodyModel({
    this.country = 'us',
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });

  factory TopHeadlinesBodyModel.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesBodyModelToJson(this);
}
