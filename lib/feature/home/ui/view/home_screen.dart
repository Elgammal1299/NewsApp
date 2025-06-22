import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/core/utils/widget/app_drawer.dart';
import 'package:news_app/feature/home/ui/view/widget/custom_carouse_slider.dart';
import 'package:news_app/feature/home/ui/view/widget/recommendation_list_view.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.background),
          onPressed: () {
            if (_scaffoldKey.currentState!.isDrawerOpen) {
              _scaffoldKey.currentState!.closeDrawer();
            } else {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.background),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes
                    .searchRoute, // Assuming you have set up a route for search
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.background),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: CustomHomeScreenBody(),
    );
  }
}

class CustomHomeScreenBody extends StatelessWidget {
  const CustomHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TopHeadlinesCubit, TopHeadlinesState>(
          buildWhen:
              (previous, current) =>
                  current is TopHeadlinesLoading ||
                  current is TopHeadlinesSuccess ||
                  current is TopHeadlinesError,
          builder: (context, state) {
            if (state is TopHeadlinesLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is TopHeadlinesError) {
              return Center(child: Text(state.errMessage));
            } else if (state is TopHeadlinesSuccess) {
              return CustomCarouseSlider(articles: state.artical);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        SizedBox(height: 20),
        Expanded(
          child: BlocBuilder<TopHeadlinesCubit, TopHeadlinesState>(
            buildWhen:
                (previous, current) =>
                    current is RecommendedNewsLoading ||
                    current is RecommendedNewsSuccess ||
                    current is RecommendedNewsError,
            builder: (context, state) {
              if (state is RecommendedNewsLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (state is RecommendedNewsError) {
                return Center(child: Text(state.errMessage));
              } else if (state is RecommendedNewsSuccess) {
                return RecommendationListView(articles: state.artical);
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
