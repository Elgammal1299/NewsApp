// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBodyModel _$SearchBodyModelFromJson(Map<String, dynamic> json) =>
    SearchBodyModel(
      searchIn: json['searchIn'] as String? ?? 'title',
      q: json['q'] as String,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      page: (json['page'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$SearchBodyModelToJson(SearchBodyModel instance) =>
    <String, dynamic>{
      'q': instance.q,
      'searchIn': instance.searchIn,
      'pageSize': instance.pageSize,
      'page': instance.page,
    };
