import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';

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
        final publishedDate = DateTime.parse(article.publishedAt);
        final formattedDate = DateFormat.yMMMMd().format(publishedDate);
        return CustomRecommendationItem(
          article: article,
          formattedDate: formattedDate,
        );
      },
    );
  }
}

class CustomRecommendationItem extends StatelessWidget {
  const CustomRecommendationItem({
    super.key,
    required this.article,
    required this.formattedDate,
  });

  final ArticleModel article;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl:
                  article.urlToImage ??
                  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: 150.0,
              height: 170.0,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                Text(
                  article.author ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
