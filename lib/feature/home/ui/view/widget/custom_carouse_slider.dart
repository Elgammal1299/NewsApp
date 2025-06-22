import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/router/app_routes.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class CustomCarouseSlider extends StatefulWidget {
  final List<ArticleModel> articles;
  const CustomCarouseSlider({super.key, required this.articles});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CustomCarouseSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders =
        widget.articles.map((articles) {
          final publishedData = DateFormat.yMMMMd().format(
            DateTime.parse(articles.publishedAt),
          );
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.homeDetails,
                arguments: articles,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        articles.urlToImage ??
                        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 280,
                  ),

                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  articles.source.name ?? '',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              Text(
                                publishedData,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          Text(
                            articles.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.articles.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 25 : 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      shape:
                          _current == entry.key
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                      color:
                          (_current == entry.key
                              ? AppColors.primary
                              : AppColors.secondary),
                      borderRadius:
                          _current == entry.key
                              ? BorderRadius.all(Radius.circular(12.0))
                              : null,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
