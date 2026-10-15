class CartItemEntity {
  const CartItemEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.image,
  });

  final int id;
  final String title;
  final String category;
  final String size;
  final String color;
  final double price;
  final int quantity;
  final String image;

  double get lineTotal => price * quantity;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      id: id,
      title: title,
      category: category,
      size: size,
      color: color,
      price: price,
      quantity: quantity ?? this.quantity,
      image: image,
    );
  }
}
