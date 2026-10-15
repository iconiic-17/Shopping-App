import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';

sealed class ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity product;
  ProductDetailsSuccess(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String error;
  ProductDetailsError(this.error);
}
