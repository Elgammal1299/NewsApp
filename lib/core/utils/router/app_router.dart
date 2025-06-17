import 'package:flutter/material.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/feature/home/ui/view/home_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.splasahRouter:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('لا يوجد بيانات '))),
        );
    }
  }
}
