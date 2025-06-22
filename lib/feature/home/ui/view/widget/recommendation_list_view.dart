import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/core/model/news_api_response.dart';
import 'package:news_app/core/widget/article_widget_item.dart';

class RecommendationListView extends StatelessWidget {
  final List<ArticleModel> articles;
  const RecommendationListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      separatorBuilder:
          (BuildContext context, int index) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        final article = articles[index];

        return CustomRecommendationItem(article: article);
      },
    );
  }
}

class CustomRecommendationItem extends StatelessWidget {
  const CustomRecommendationItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ArticleWidgetItem(article: article),
    );
  }
}
