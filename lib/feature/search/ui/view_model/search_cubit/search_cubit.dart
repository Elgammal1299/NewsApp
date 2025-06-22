import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/model/news_api_response.dart';
import 'package:news_app/feature/search/data/model/search_body_model.dart';
import 'package:news_app/feature/search/data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  Future<void> getSearch(String searchKeyWord) async {
    emit(SearchLoading());
    final model = SearchBodyModel(q: searchKeyWord);

    final responce = await searchRepo.getSearch(model.toCleanQuery());
    responce.fold(
      (failure) {
        emit(SearchError(failure.errMessage));
      },
      (success) {
        emit(SearchSuccess(success.articles));
      },
    );
  }
}
