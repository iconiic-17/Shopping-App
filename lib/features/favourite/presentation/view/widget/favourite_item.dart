import 'package:flutter/material.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/app_product_card.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/favourite/domain/entities/favourit_item_entity.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    super.key,
    required this.product,
    this.layout = ProductCardLayout.grid,
  });

  final FavouriteItemEntity product;
  final ProductCardLayout layout;

  @override
  Widget build(BuildContext context) {
    return AppProductCard(product: product.toProduct(), layout: layout);
  }
}
