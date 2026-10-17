import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/presentation/view/screens/product_details_screen.dart';

class AppProductCard extends StatelessWidget {
  const AppProductCard({
    super.key,
    required this.product,
    this.layout = ProductCardLayout.grid,
  });

  final ProductItemEntity product;
  final ProductCardLayout layout;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select(
      (FavouriteCubit cubit) => cubit.isFavourite(product.id),
    );
    final isInCart = context.select(
      (CartCubit cubit) => cubit.isInCart(product.id),
    );

    return ProductItemCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      title: product.title,
      category: product.category,
      discount: product.discountPercentage,
      price: product.price,
      rating: product.rating,
      image: product.primaryImage,
      isFavorite: isFavorite,
      isInCart: isInCart,
      layout: layout,
      onFavoriteTap: () =>
          context.read<FavouriteCubit>().toggleFavourite(product),
      addToCartOnTap: () => context.read<CartCubit>().addToCart(product),
    );
  }
}
