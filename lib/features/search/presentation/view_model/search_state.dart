import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductItemEntity> products;
  SearchSuccess(this.products);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
