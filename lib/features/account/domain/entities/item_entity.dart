class UserProfileEntity {
  const UserProfileEntity({
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

  UserProfileEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? image,
  }) {
    return UserProfileEntity(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
    );
  }
}

class UpdateProfileParams {
  const UpdateProfileParams({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.imagePath,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? address;
  final String? imagePath;
}
