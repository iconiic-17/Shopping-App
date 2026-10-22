import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/utils/json_numbers.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';

class FavouriteItemDto {
  FavouriteItemDto({
    this.id,
    this.title,
    this.category,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
  });

  int? id;
  String? title;
  String? category;
  String? description;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? images;

  factory FavouriteItemDto.fromJson(Map<String, dynamic> json) {
    final map = productMapOf(json);
    return FavouriteItemDto(
      id: asInt(
        map['id'] ?? map['productId'] ?? json['id'] ?? json['productId'],
      ),
      title: map['title'] as String?,
      category: map['category'] as String?,
      description: map['description'] as String?,
      price: asDouble(map['price'] ?? json['price']),
      discountPercentage: asDouble(
        map['discountPercentage'] ?? json['discountPercentage'],
      ),
      rating: asDouble(map['rating'] ?? json['rating']),
      images: _imagesOf(map, json),
    );
  }

  FavouriteItemEntity toEntity() {
    return FavouriteItemEntity(
      id: id ?? 0,
      title: title ?? '',
      category: category ?? '',
      description: description ?? '',
      price: price ?? 0.0,
      discountPercentage: discountPercentage ?? 0.0,
      rating: rating ?? 0.0,
      images: images ?? const [],
    );
  }

  static List<String> _imagesOf(
    Map<String, dynamic> map,
    Map<String, dynamic> json,
  ) {
    final raw = map['images'] ?? json['images'];
    if (raw is List) {
      final list = raw
          .map((e) => SafeNetworkImage.normalize(e?.toString() ?? ''))
          .where((e) => e.isNotEmpty)
          .toList();
      if (list.isNotEmpty) return list;
    }
    final single = map['image'] ?? map['thumbnail'] ?? json['image'];
    if (single != null) {
      final url = SafeNetworkImage.normalize(single.toString());
      if (url.isNotEmpty) return [url];
    }
    return const [];
  }
}
