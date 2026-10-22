import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class FavouriteItemEntity {
  final int id;
  final String title;
  final String category;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> images;

  const FavouriteItemEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.images,
  });

  String get primaryImage => images.isNotEmpty ? images.first : '';

  factory FavouriteItemEntity.fromProduct(ProductItemEntity product) {
    return FavouriteItemEntity(
      id: product.id,
      title: product.title,
      category: product.category,
      description: product.description,
      price: product.price,
      discountPercentage: product.discountPercentage,
      rating: product.rating,
      images: product.images,
    );
  }

  ProductItemEntity toProduct() {
    return ProductItemEntity(
      id: id,
      title: title,
      category: category,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      images: images,
    );
  }

  ProductWriteRequest toWriteRequest() {
    return ProductWriteRequest(
      productId: id,
      title: title,
      category: category,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      image: primaryImage,
    );
  }
}
