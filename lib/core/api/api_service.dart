import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/core/constant/api_constants.dart';
import 'package:news_app/feature/home/data/model/top_headlines_body_model.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

/// This is the API service class that handles all the API calls.
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    ParseErrorLogger? errorLogger,
    String? baseUrl,
  }) = _ApiService;

  @GET(ApiConstants.topHeadlines)
  Future<TopHeadlinesResponse> getTopHeadlines(
    @Queries() Map<String, dynamic> query,
  );
}

    // @Query('topHeadlinesBodyModel') TopHeadlinesBodyModel topHeadlinesBodyModel,