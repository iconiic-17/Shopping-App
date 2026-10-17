import 'package:shopping_app/core/constants/app_constants.dart';
import 'package:shopping_app/core/network/api_helpers.dart';

class ProductResponseEntity {
  List<ProductItemEntity> list;
  int total;
  int skip;
  int limit;

  ProductResponseEntity({
    this.list = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });
}

class ProductItemEntity {
  int id;
  String title;
  String category;
  String description;
  double price;
  double discountPercentage;
  double rating;
  List<String> images;

  ProductItemEntity({
    this.id = 1,
    this.title = "title",
    this.category = '',
    this.description = '',
    this.price = 100,
    this.discountPercentage = 7,
    this.rating = 5.0,
    this.images = const [AppConstants.image],
  });

  String get primaryImage => images.isNotEmpty ? images.first : '';

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
