import 'package:json_annotation/json_annotation.dart';

part 'top_headlines_body_model.g.dart';

@JsonSerializable()
class TopHeadlinesBodyModel {
  final String country;
  final String? category;
  final String? sources;
  final String? q;

  @JsonKey(name: 'pageSize')
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

  /// من JSON
  factory TopHeadlinesBodyModel.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesBodyModelFromJson(json);

  /// إلى JSON كامل
  Map<String, dynamic> toJson() => _$TopHeadlinesBodyModelToJson(this);

  /// JSON بعد تنظيف القيم الفارغة (للاستخدام مع QueryMap)
  Map<String, dynamic> toCleanQuery() {
    final map = toJson();
    map.removeWhere((key, value) => value == null || value.toString().isEmpty);
    return map;
  }
}
