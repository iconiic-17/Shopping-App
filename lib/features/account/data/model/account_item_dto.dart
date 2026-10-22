import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/features/account/domain/entities/account_item_entity.dart';

class UserProfileDto {
  const UserProfileDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String image;

  factory UserProfileDto.fromJson(dynamic rawJson) {
    if (rawJson is! Map) {
      return const UserProfileDto(
        id: '',
        name: '',
        email: '',
        phone: '',
        address: '',
        image: '',
      );
    }

    final json = Map<String, dynamic>.from(rawJson);
    final map = (json['message'] is Map)
        ? Map<String, dynamic>.from(json['message'] as Map)
        : (json['user'] is Map)
        ? Map<String, dynamic>.from(json['user'] as Map)
        : (json['data'] is Map)
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;

    var rawImage = (map['image'] ?? map['profilePic'] ?? map['avatar'] ?? '')
        .toString();
    if (rawImage.isNotEmpty && !rawImage.startsWith('http')) {
      if (rawImage.startsWith('/')) {
        rawImage = '${ApiConstants.baseUrl}$rawImage';
      } else {
        rawImage = '${ApiConstants.baseUrl}/$rawImage';
      }
    }

    return UserProfileDto(
      id: (map['_id'] ?? map['id'] ?? '').toString(),
      name: (map['name'] ?? map['userName'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      phone: (map['phone'] ?? '').toString(),
      address: (map['address'] ?? '').toString(),
      image: rawImage,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address.isEmpty ? 'Not provided' : address,
      image: image,
    );
  }
}
