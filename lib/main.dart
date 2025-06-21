import 'package:flutter/material.dart';
import 'package:news_app/core/DI/setup_get_it.dart';
import 'package:news_app/core/utils/router/app_router.dart';
import 'package:news_app/core/utils/router/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
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
      initialRoute: AppRoutes.homeRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
