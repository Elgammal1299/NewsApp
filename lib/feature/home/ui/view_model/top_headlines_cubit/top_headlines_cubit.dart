import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/db/news_db.dart';
import 'package:news_app/core/model/news_local.dart';
import 'package:news_app/feature/home/data/model/top_headlines_body_model.dart';
import 'package:news_app/core/model/news_api_response.dart';
import 'package:news_app/feature/home/data/repo/top_headlines_repo.dart';

part 'top_headlines_state.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit(this.topHeadlinesRepo) : super(TopHeadlinesInitial());
  final TopHeadlinesRepo topHeadlinesRepo;
  // Future<void> getTopHeadlines() async {
  //   emit(TopHeadlinesLoading());
  //   final model = TopHeadlinesBodyModel(
  //     category: 'health',
  //     page: 1,
  //     pageSize: 8,
  //   );
  //   final responce = await topHeadlinesRepo.getTopHeadlines(
  //     model.toCleanQuery(),
  //   );
  //   responce.fold(
  //     (failure) {
  //       emit(TopHeadlinesError(failure.errMessage));
  //     },
  //     (success) {

  //       emit(TopHeadlinesSuccess(success.articles));
  //     },
  //   );
  // }
  Future<void> getTopHeadlines() async {
    emit(TopHeadlinesLoading());

    final model = TopHeadlinesBodyModel(
      category: 'health',
      page: 1,
      pageSize: 7,
    );

    final response = await topHeadlinesRepo.getTopHeadlines(
      model.toCleanQuery(),
    );

    response.fold(
      // في حالة الخطأ
      (failure) async {
        final localNews = await NewsDatabase.instance.getAllNews(
          'top_headlines',
        );

        if (localNews.isNotEmpty) {
          // نحولها لو عايز تعرض ArticleModel بدل News
          final articles =
              localNews
                  .map(
                    (n) => ArticleModel(
                      title: n.title,
                      description: n.description,
                      url: n.url,
                      urlToImage: n.urlToImage,
                      publishedAt: n.publishedAt,
                      content: n.content,
                      author: n.author,
                      source: SourceModel(name: n.sourceName),
                    ),
                  )
                  .toList();

          emit(TopHeadlinesSuccess(articles));
        } else {
          emit(TopHeadlinesError(failure.errMessage));
        }
      },

      // في حالة النجاح
      (success) async {
        final newsList =
            success.articles
                .map((article) => NewsLocal.fromArticleModel(article))
                .toList();

        await NewsDatabase.instance.insertNewsList('top_headlines', newsList);
        emit(TopHeadlinesSuccess(success.articles));
      },
    );
  }

  // Future<void> getRecommendedNews() async {
  //   emit(RecommendedNewsLoading());
  //   final model = TopHeadlinesBodyModel(page: 1, pageSize: 15);
  //   final responce = await topHeadlinesRepo.getTopHeadlines(
  //     model.toCleanQuery(),
  //   );
  //   responce.fold(
  //     (failure) {
  //       emit(RecommendedNewsError(failure.errMessage));
  //     },
  //     (success) {
  //       emit(RecommendedNewsSuccess(success.articles));
  //     },
  //   );
  // }
  Future<void> getRecommendedNews() async {
    emit(RecommendedNewsLoading());

    final model = TopHeadlinesBodyModel(page: 1, pageSize: 15);

    final response = await topHeadlinesRepo.getTopHeadlines(
      model.toCleanQuery(),
    );

    response.fold(
      (failure) async {
        // نحاول نجيب البيانات من SQLite
        final localNews = await NewsDatabase.instance.getAllNews(
          'recommended_news',
        );

        if (localNews.isNotEmpty) {
          // نحول News إلى ArticleModel
          final articles =
              localNews
                  .map(
                    (n) => ArticleModel(
                      title: n.title,
                      description: n.description,
                      url: n.url,
                      urlToImage: n.urlToImage,
                      publishedAt: n.publishedAt,
                      content: n.content,
                      author: n.author,
                      source: SourceModel(name: n.sourceName),
                    ),
                  )
                  .toList();

          emit(RecommendedNewsSuccess(articles));
        } else {
          emit(RecommendedNewsError(failure.errMessage));
        }
      },
      (success) async {
        final newsList =
            success.articles
                .map((article) => NewsLocal.fromArticleModel(article))
                .toList();

        await NewsDatabase.instance.insertNewsList(
          'recommended_news',
          newsList,
        );

        emit(RecommendedNewsSuccess(success.articles));
      },
    );
  }
}
