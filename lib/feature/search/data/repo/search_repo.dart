import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/api/api_service.dart';
import 'package:news_app/core/error/Failure.dart';
import 'package:news_app/core/model/news_api_response.dart';

class SearchRepo {
  final ApiService apiService;

  SearchRepo(this.apiService);

  Future<Either<Failure, NewsApiResponse>> getSearch(
    Map<String, dynamic> searchBodyModel,
  ) async {
    try {
      final response = await apiService.getSearch(searchBodyModel);
      return Right(response);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
