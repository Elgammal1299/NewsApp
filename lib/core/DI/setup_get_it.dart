import 'package:dio/dio.dart';
import 'package:news_app/core/api/api_service.dart';
import 'package:news_app/core/api/dio_factory.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/feature/home/data/repo/top_headlines_repo.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';

/// This is the dependency injection file for the app.
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio Instance
  Dio dio = await DioFactory.getDio();

  // ✅ Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // ✅ Register UserDataRepo
  getIt.registerLazySingleton<TopHeadlinesRepo>(
    () => TopHeadlinesRepo(getIt<ApiService>()),
  );

  // ✅ Register Cubit
  getIt.registerFactory<TopHeadlinesCubit>(
    () => TopHeadlinesCubit(getIt<TopHeadlinesRepo>()),
  );
}
