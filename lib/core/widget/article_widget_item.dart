import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/model/news_api_response.dart';
import 'package:news_app/core/utils/router/app_routes.dart';

class ArticleWidgetItem extends StatelessWidget {
  final ArticleModel article;
  final bool isSmaller;
  const ArticleWidgetItem({
    super.key,
    required this.article,
    this.isSmaller = false,
  });

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(article.publishedAt);
    final formattedDate = DateFormat.yMMMMd().format(publishedDate);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.homeDetails, arguments: article);
      },
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
              width: isSmaller ? 120 : 150.0,
              height: isSmaller ? 140 : 170.0,
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
                  style:
                      isSmaller
                          ? TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          : TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                Text(
                  article.author ?? '',
                  style:
                      isSmaller
                          ? TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                          : TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
