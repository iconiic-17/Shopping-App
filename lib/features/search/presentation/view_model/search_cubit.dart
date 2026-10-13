import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/utils/debouncer.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/search/domain/use_case/search_products_use_case.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._useCase) : super(SearchInitial());

  final SearchProductsUseCase _useCase;
  final Debouncer _debouncer = Debouncer();
  int _requestId = 0;

  void onQueryChanged(String value) {
    final query = value.trim();

    if (query.isEmpty) {
      _debouncer.cancel();
      _requestId++;
      emit(SearchInitial());
      return;
    }

    _debouncer.run(() => _search(query));
  }

  Future<void> _search(String query) async {
    final id = ++_requestId;
    emit(SearchLoading());

    final result = await _useCase.invoke(query);
    if (id != _requestId) return;

    switch (result) {
      case Success<ProductResponseEntity>():
        final list = result.data.list;
        emit(list.isEmpty ? SearchEmpty() : SearchSuccess(list));
      case Error<ProductResponseEntity>():
        emit(SearchError(result.messageError));
    }
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    return super.close();
  }
}
