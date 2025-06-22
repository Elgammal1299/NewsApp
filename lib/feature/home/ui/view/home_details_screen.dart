import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';

class HomeDetailsScreen extends StatelessWidget {
  final ArticleModel articles;
  const HomeDetailsScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final publishedDate = DateTime.parse(articles.publishedAt);
    final formattedDate = DateFormat.yMMMMd().format(publishedDate);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement share functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Implement bookmark functionality here
            },
          ),
        ],
        title: Text('Home Details'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                articles.urlToImage ??
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
            placeholder:
                (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
            height: size.height * 0.5,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.center,
                begin: Alignment.bottomCenter,
                colors: [AppColors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * .3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            articles.source.name ?? '',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        articles.title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Trending Now . $formattedDate',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(36),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: CachedNetworkImageProvider(
                                  articles.urlToImage ??
                                      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                articles.source.name ?? '',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            (articles.description ?? '') +
                                (articles.description ?? ''),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
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
