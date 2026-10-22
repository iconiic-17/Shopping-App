import 'package:shopping_app/core/utils/json_numbers.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';

class ReviewDto {
  final String? reviewerName;
  final double? rating;
  final String? comment;

  ReviewDto.fromJson(Map<String, dynamic> json)
    : reviewerName = json['reviewerName'] as String?,
      rating = asDouble(json['rating']),
      comment = json['comment'] as String?;

  ReviewEntity toEntity() => ReviewEntity(
    reviewerName: reviewerName ?? 'Anonymous',
    rating: rating ?? 0.0,
    comment: comment ?? '',
  );
}

class ProductDetailsDto {
  final int? id;
  final String? title;
  final String? category;
  final String? description;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final List<String>? images;
  final List<ReviewDto>? reviews;

  const ProductDetailsDto._({
    this.id,
    this.title,
    this.category,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
    this.reviews,
  });

  factory ProductDetailsDto.fromJson(Map<String, dynamic> json) {
    return ProductDetailsDto._(
      id: asInt(json['id']),
      title: json['title'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
      price: asDouble(json['price']),
      discountPercentage: asDouble(json['discountPercentage']),
      rating: asDouble(json['rating']),
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      reviews: (json['reviews'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => ReviewDto.fromJson(e))
          .toList(),
    );
  }

  ProductDetailsEntity toEntity() => ProductDetailsEntity(
    id: id ?? 0,
    title: title ?? '',
    category: category ?? '',
    description: description ?? '',
    price: price ?? 0.0,
    discountPercentage: discountPercentage ?? 0.0,
    rating: rating ?? 0.0,
    images: images ?? const [],
    reviews: reviews?.map((e) => e.toEntity()).toList() ?? const [],
  );
}
