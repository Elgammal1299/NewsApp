part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ArticleModel> articles;

  SearchSuccess(this.articles);
}

final class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}
