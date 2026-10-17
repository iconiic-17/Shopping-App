import 'package:shopping_app/core/utils/json_numbers.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class ProductResponseDto {
  List<ProductItemDto>? list;
  int? total;
  int? skip;
  int? limit;

  ProductResponseDto({this.list, this.total, this.skip, this.limit});

  ProductResponseDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ProductItemDto>[];
      json['list'].forEach((v) {
        list!.add(ProductItemDto.fromJson(v));
      });
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
  String? category;
  String? description;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? images;

  ProductItemDto({
    this.id,
    this.title,
    this.category,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
  });

  ProductItemDto.fromJson(Map<String, dynamic> json) {
    id = asInt(json['id']);
    title = json['title'] as String?;
    category = json['category'] as String?;
    description = json['description'] as String?;
    price = asDouble(json['price']);
    discountPercentage = asDouble(json['discountPercentage']);
    rating = asDouble(json['rating']);
    images = _imagesOf(json);
  }

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id ?? 0,
      title: title ?? '',
      category: category ?? '',
      description: description ?? '',
      price: price ?? 0,
      discountPercentage: discountPercentage ?? 0,
      rating: rating ?? 0,
      images: images ?? [],
    );
  }

  static List<String> _imagesOf(Map<String, dynamic> json) {
    final collected = <String>[];
    final rawImages = json['images'];
    if (rawImages is List) {
      collected.addAll(rawImages.map((e) => e.toString()));
    } else if (rawImages is String) {
      collected.add(rawImages);
    }
    if (json['thumbnail'] != null) collected.add(json['thumbnail'].toString());
    if (json['image'] != null) collected.add(json['image'].toString());
    return collected
        .map(SafeNetworkImage.normalize)
        .where((url) => url.isNotEmpty)
        .toList();
  }
}
