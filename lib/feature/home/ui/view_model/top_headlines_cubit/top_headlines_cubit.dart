import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/data/model/top_headlines_body_model.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';
import 'package:news_app/feature/home/data/repo/top_headlines_repo.dart';

part 'top_headlines_state.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit(this.topHeadlinesRepo) : super(TopHeadlinesInitial());
  final TopHeadlinesRepo topHeadlinesRepo;
  Future<void> getTopHeadlines() async {
    emit(TopHeadlinesLoading());
    final model = TopHeadlinesBodyModel(
      category: 'health',
      page: 1,
      pageSize: 8,
    );
    final responce = await topHeadlinesRepo.getTopHeadlines(
      model.toCleanQuery(),
    );
    responce.fold(
      (failure) {
        emit(TopHeadlinesError(failure.errMessage));
      },
      (success) {
        emit(TopHeadlinesSuccess(success.articles));
      },
    );
  }

  Future<void> getRecommendedNews() async {
    emit(RecommendedNewsLoading());
    final model = TopHeadlinesBodyModel(page: 1, pageSize: 15);
    final responce = await topHeadlinesRepo.getTopHeadlines(
      model.toCleanQuery(),
    );
    responce.fold(
      (failure) {
        emit(RecommendedNewsError(failure.errMessage));
      },
      (success) {
        emit(RecommendedNewsSuccess(success.articles));
      },
    );
  }
}
