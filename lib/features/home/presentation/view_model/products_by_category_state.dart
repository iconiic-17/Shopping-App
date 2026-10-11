import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class ProductsByCategoryState {}

class PBCInitial extends ProductsByCategoryState {}

class PBCLoading extends ProductsByCategoryState {}

class PBCSuccess extends ProductsByCategoryState {
  final List<ProductItemEntity> products;
  PBCSuccess(this.products);
}

class PBCEmpty extends ProductsByCategoryState {}

class PBCError extends ProductsByCategoryState {
  final String error;
  PBCError(this.error);
}
