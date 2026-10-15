import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/app_product_card.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    super.key,
    required this.product,
    this.layout = ProductCardLayout.grid,
  });

  final ProductItemEntity product;
  final ProductCardLayout layout;

  @override
  Widget build(BuildContext context) {
    return AppProductCard(product: product, layout: layout);
  }
}
