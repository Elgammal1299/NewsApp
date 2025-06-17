import 'package:flutter/material.dart';
import 'package:news_app/core/utils/router/app_router.dart';
import 'package:news_app/core/utils/router/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splasahRouter,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
