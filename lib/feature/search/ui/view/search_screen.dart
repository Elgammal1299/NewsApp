import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/widget/article_widget_item.dart';
import 'package:news_app/feature/search/ui/view_model/search_cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: TextButton(
                  child: Text('Search', style: TextStyle(fontSize: 16)),
                  onPressed:
                      () async => BlocProvider.of<SearchCubit>(
                        context,
                      ).getSearch(_searchController.text),
                ),

                hintText: 'search by title ',
              ),
              // onSubmitted: (value) {
              //  BlocProvider.of<SearchCubit>(context).getSearch(value);
              // },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is SearchError) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage}',
                      style: TextStyle(color: AppColors.error),
                    ),
                  );
                } else if (state is SearchSuccess) {
                  if (state.articles.isEmpty) {
                    return Center(child: Text('No articles found'));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder:
                          (context, index) => SizedBox(height: 16),
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return ArticleWidgetItem(
                          article: state.articles[index],
                          isSmaller: true,
                        );
                      },
                    ),
                  );
                } else {
                  return Text('Search for news articles ');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
