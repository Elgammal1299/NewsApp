import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/DI/setup_get_it.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/feature/home/ui/view/home_screen.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.splasahRouter:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => getIt<TopHeadlinesCubit>()..getTopHeadlines(),
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
