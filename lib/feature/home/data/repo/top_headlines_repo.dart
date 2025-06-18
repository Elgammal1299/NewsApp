import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/api/api_service.dart';
import 'package:news_app/core/error/Failure.dart';
import 'package:news_app/feature/home/data/model/top_headlines_body_model.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';

class TopHeadlinesRepo {
  final ApiService apiService;

  TopHeadlinesRepo(this.apiService);

  Future<Either<Failure, TopHeadlinesResponse>> getTopHeadlines(
    TopHeadlinesBodyModel topHeadlinesBodyModel,
  ) async {
    try {
      final response = await apiService.getTopHeadlines(topHeadlinesBodyModel);
      return Right(response);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
