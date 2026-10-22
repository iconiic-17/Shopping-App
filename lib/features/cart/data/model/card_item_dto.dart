import 'package:shopping_app/core/utils/json_numbers.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/cart/domain/entities/card_item_entity.dart';

class CartItemDto {
  CartItemDto({
    this.id,
    this.title,
    this.category,
    this.size,
    this.color,
    this.price,
    this.quantity,
    this.image,
  });

  int? id;
  String? title;
  String? category;
  String? size;
  String? color;
  double? price;
  int? quantity;
  String? image;

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    final product = json['product'] is Map
        ? Map<String, dynamic>.from(json['product'] as Map)
        : json;

    return CartItemDto(
      id: asInt(product['id'] ?? json['id'] ?? json['productId']),
      title: product['title'] as String?,
      category: product['category'] as String?,
      size: (json['size'] ?? product['size']) as String?,
      color: (json['color'] ?? product['color']) as String?,
      price: asDouble(product['price'] ?? json['price']),
      quantity: asInt(json['quantity'] ?? json['count'] ?? 1),
      image: _imageOf(product, json),
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id ?? 0,
      title: title ?? '',
      category: category ?? '',
      size: size ?? '',
      color: color ?? '',
      price: price ?? 0,
      quantity: (quantity == null || quantity! <= 0) ? 1 : quantity!,
      image: image ?? '',
    );
  }

  static String? _imageOf(
    Map<String, dynamic> product,
    Map<String, dynamic> json,
  ) {
    final candidates = <dynamic>[
      if (product['images'] is List && (product['images'] as List).isNotEmpty)
        (product['images'] as List).first,
      if (product['images'] is String) product['images'],
      product['thumbnail'],
      json['thumbnail'],
      product['image'],
      json['image'],
    ];
    for (final candidate in candidates) {
      if (candidate == null) continue;
      final url = SafeNetworkImage.normalize(candidate.toString());
      if (url.isNotEmpty) return url;
    }
    return null;
  }
}
