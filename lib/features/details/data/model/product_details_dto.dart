import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';

class ReviewDto {
  final String? reviewerName;
  final num? rating;
  final String? comment;

  ReviewDto.fromJson(Map<String, dynamic> json)
    : reviewerName = json['reviewerName'],
      rating = json['rating'],
      comment = json['comment'];

  ReviewEntity toEntity() => ReviewEntity(
    reviewerName: reviewerName ?? 'Anonymous',
    rating: (rating ?? 0).toDouble(),
    comment: comment ?? '',
  );
}

class ProductDetailsDto {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final List<String>? images;
  final List<ReviewDto>? reviews;

  const ProductDetailsDto._({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
    this.reviews,
  });

  factory ProductDetailsDto.fromJson(Map<String, dynamic> json) {
    return ProductDetailsDto._(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      reviews: (json['reviews'] as List?)
          ?.map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ProductDetailsEntity toEntity() => ProductDetailsEntity(
    id: id ?? 0,
    title: title ?? '',
    description: description ?? '',
    price: (price ?? 0).toDouble(),
    discountPercentage: (discountPercentage ?? 0).toDouble(),
    rating: (rating ?? 0).toDouble(),
    images: images ?? const [],
    reviews: reviews?.map((e) => e.toEntity()).toList() ?? const [],
  );
}
