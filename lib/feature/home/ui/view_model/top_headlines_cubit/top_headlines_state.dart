part of 'top_headlines_cubit.dart';

sealed class TopHeadlinesState {}

final class TopHeadlinesInitial extends TopHeadlinesState {}

final class TopHeadlinesLoading extends TopHeadlinesState {}

final class TopHeadlinesSuccess extends TopHeadlinesState {
  final List<ArticleModel> artical;

  TopHeadlinesSuccess(this.artical);
}

final class TopHeadlinesError extends TopHeadlinesState {
  final String errMessage;

  TopHeadlinesError(this.errMessage);
}
