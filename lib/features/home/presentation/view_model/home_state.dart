import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HProductsLoading extends HomeState {}

class HProductsSuccess extends HomeState {
  final List<ProductItemEntity> productItemEntity;
  HProductsSuccess(this.productItemEntity);
}

class HProductsError extends HomeState {
  final String error;
  HProductsError(this.error);
}

class CProductsLoading extends HomeState {}

class CProductsSuccess extends HomeState {
  final List<CategoryItemEntity> categortItemEntity;
  CProductsSuccess(this.categortItemEntity);
}

class CProductsError extends HomeState {
  final String error;
  CProductsError(this.error);
}
