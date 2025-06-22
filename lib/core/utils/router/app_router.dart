import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/DI/setup_get_it.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/core/model/news_api_response.dart';
import 'package:news_app/feature/home/ui/view/home_details_screen.dart';
import 'package:news_app/feature/home/ui/view/home_screen.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';
import 'package:news_app/feature/search/ui/view/search_screen.dart';
import 'package:news_app/feature/search/ui/view_model/search_cubit/search_cubit.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.splasahRouter:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.homeDetails:
        final articles = settings.arguments as ArticleModel;
        return MaterialPageRoute(
          builder: (_) => HomeDetailsScreen(articles: articles),
        );
      case AppRoutes.searchRoute:
        // final articles = settings.arguments as ArticleModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SearchCubit>(),
                child: SearchScreen(),
              ),
        );
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<TopHeadlinesCubit>()
                          ..getTopHeadlines()
                          ..getRecommendedNews(),
                child: HomeScreen(),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('لا يوجد بيانات '))),
        );
    }
  }
}
