import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/error/Failure.dart';
import 'package:news_app/feature/home/data/model/top_headlines_body_model.dart';
import 'package:news_app/feature/home/data/model/top_headlines_response.dart';
import 'package:news_app/feature/home/data/repo/top_headlines_repo.dart';

part 'top_headlines_state.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit(this.topHeadlinesRepo) : super(TopHeadlinesInitial());
  final TopHeadlinesRepo topHeadlinesRepo;
  Future<void> getTopHeadlines() async {
    emit(TopHeadlinesLoading());
    final responce = await topHeadlinesRepo.getTopHeadlines(
      TopHeadlinesBodyModel(category: 'health'),
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
}
