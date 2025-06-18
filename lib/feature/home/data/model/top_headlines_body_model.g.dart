// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_headlines_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesBodyModel _$TopHeadlinesBodyModelFromJson(
  Map<String, dynamic> json,
) => TopHeadlinesBodyModel(
  country: json['country'] as String? ?? 'us',
  category: json['category'] as String?,
  sources: json['sources'] as String?,
  q: json['q'] as String?,
  pageSize: (json['pageSize'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
);

Map<String, dynamic> _$TopHeadlinesBodyModelToJson(
  TopHeadlinesBodyModel instance,
) => <String, dynamic>{
  'country': instance.country,
  'category': instance.category,
  'sources': instance.sources,
  'q': instance.q,
  'pageSize': instance.pageSize,
  'page': instance.page,
};
