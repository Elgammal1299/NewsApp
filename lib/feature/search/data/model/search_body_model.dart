import 'package:json_annotation/json_annotation.dart';

part 'search_body_model.g.dart';

@JsonSerializable()
class SearchBodyModel {
  final String q;
  final String searchIn;
  @JsonKey(name: 'pageSize')
  final int pageSize;

  final int page;

  SearchBodyModel({
    this.searchIn = 'title',
    required this.q,
    this.pageSize = 10,
    this.page = 1,
  });

  /// من JSON
  factory SearchBodyModel.fromJson(Map<String, dynamic> json) =>
      _$SearchBodyModelFromJson(json);

  /// إلى JSON كامل
  Map<String, dynamic> toJson() => _$SearchBodyModelToJson(this);

  /// JSON بعد تنظيف القيم الفارغة (للاستخدام مع QueryMap)
  Map<String, dynamic> toCleanQuery() {
    final map = toJson();
    map.removeWhere((key, value) => value == null || value.toString().isEmpty);
    return map;
  }
}
