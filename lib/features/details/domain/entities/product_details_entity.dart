class ReviewEntity {
  final String reviewerName;
  final double rating;
  final String comment;

  const ReviewEntity({
    required this.reviewerName,
    required this.rating,
    required this.comment,
  });
}

class ProductDetailsEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> images;
  final List<ReviewEntity> reviews;

  const ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.images,
    required this.reviews,
  });
}
