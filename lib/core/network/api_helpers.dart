import 'package:dio/dio.dart';

List<dynamic> extractApiList(dynamic data, {List<String> keys = const []}) {
  if (data is List) return data;
  if (data is Map) {
    for (final key in keys) {
      final value = data[key];
      if (value is List) return value;
      if (value is Map) {
        for (final nestedKey in keys) {
          final nested = value[nestedKey];
          if (nested is List) return nested;
        }
      }
    }
  }
  return const [];
}

String dioErrorMessage(DioException e) {
  final data = e.response?.data;
  final statusCode = e.response?.statusCode;

  if (data is Map) {
    final msg = (data['message'] ?? data['error'])?.toString() ?? '';
    if (msg.isNotEmpty) {
      // Server-side bug: the backend fails to fetch from dummyjson
      if (msg == 'Invalid URL' && statusCode == 500) {
        return 'Server error — please try again later';
      }
      return msg;
    }
  }

  if (statusCode != null) return 'Server error: $statusCode';
  return e.message ?? 'Network error';
}

Map<String, dynamic> productMapOf(Map<String, dynamic> json) {
  if (json['product'] is Map) {
    return Map<String, dynamic>.from(json['product'] as Map);
  }
  return json;
}

class ProductWriteRequest {
  const ProductWriteRequest({
    required this.productId,
    this.title = '',
    this.category = '',
    this.description = '',
    this.price = 0,
    this.discountPercentage = 0,
    this.rating = 0,
    this.image = '',
  });

  final int productId;
  final String title;
  final String category;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final String image;

  Map<String, dynamic> toJson() {
    final dummyJsonUrl = 'https://dummyjson.com/products/$productId';
    return {
      'productId': productId,
      'id': productId,
      'quantity': 1,
      'title': title,
      'category': category,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'url': dummyJsonUrl,
      'productUrl': dummyJsonUrl,
      if (image.isNotEmpty) 'image': image,
      if (image.isNotEmpty) 'thumbnail': image,
    };
  }
}
