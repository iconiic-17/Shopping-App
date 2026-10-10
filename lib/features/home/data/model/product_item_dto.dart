import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class ProductResponseDto {
  List<ProductItemDto>? list;
  int? total;
  int? skip;
  int? limit;

  ProductResponseDto({this.list, this.total, this.skip, this.limit});

  ProductResponseDto.fromJson(Map<String, dynamic> json) {
    // غيّر 'list' لـ 'products' لو ده اسم المفتاح في الـ API
    if (json['list'] != null) {
      list = (json['list'] as List)
          .map((v) => ProductItemDto.fromJson(v))
          .toList();
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  ProductResponseEntity toEntity() {
    return ProductResponseEntity(
      list: list?.map((e) => e.toEntity()).toList() ?? [],
      total: total ?? 0,
      skip: skip ?? 0,
      limit: limit ?? 0,
    );
  }
}

class ProductItemDto {
  int? id;
  String? title;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? images;

  ProductItemDto({
    this.id,
    this.title,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
  });

  ProductItemDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();
    images = (json['images'] as List?)?.cast<String>();
  }

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id ?? 0,
      title: title ?? '',
      price: price ?? 0,
      discountPercentage: discountPercentage ?? 0,
      rating: rating ?? 0,
      images: images ?? [],
    );
  }
}
