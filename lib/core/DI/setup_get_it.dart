import 'package:dio/dio.dart';
import 'package:news_app/core/api/api_service.dart';
import 'package:news_app/core/api/dio_factory.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/feature/home/data/repo/top_headlines_repo.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';
import 'package:news_app/feature/search/data/repo/search_repo.dart';
import 'package:news_app/feature/search/ui/view_model/search_cubit/search_cubit.dart';

/// This is the dependency injection file for the app.
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio Instance
  Dio dio = await DioFactory.getDio();

  // ✅ Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // ✅ Register TopHeadlinesRepo
  getIt.registerLazySingleton<TopHeadlinesRepo>(
    () => TopHeadlinesRepo(getIt<ApiService>()),
  );

  // ✅ Register TopHeadlinesCubit
  getIt.registerFactory<TopHeadlinesCubit>(
    () => TopHeadlinesCubit(getIt<TopHeadlinesRepo>()),
  );
  // ✅ Register SearchRepo
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepo(getIt<ApiService>()),
  );

  // ✅ Register SearchCubit
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));
}
