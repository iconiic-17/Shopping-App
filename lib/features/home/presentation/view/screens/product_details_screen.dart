import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/widgets/app_snackbar.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductItemEntity product;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select(
      (FavouriteCubit cubit) => cubit.isFavourite(product.id),
    );
    final isInCart = context.select(
      (CartCubit cubit) => cubit.isInCart(product.id),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartActionError) {
              showAppSnackBar(context, message: state.message, isError: true);
            } else if (state is CartActionSuccess) {
              showAppSnackBar(context, message: state.message, isError: false);
            }
          },
        ),
        BlocListener<FavouriteCubit, FavouriteState>(
          listener: (context, state) {
            if (state is FavouriteActionError) {
              showAppSnackBar(context, message: state.message, isError: true);
            } else if (state is FavouriteActionSuccess) {
              showAppSnackBar(context, message: state.message, isError: false);
            }
          },
        ),
      ],
      child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            onPressed: () =>
                context.read<FavouriteCubit>().toggleFavourite(product),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.error : AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: PageView.builder(
                    itemCount: product.images.isEmpty ? 1 : product.images.length,
                    itemBuilder: (context, index) {
                      final url = product.images.isEmpty
                          ? ''
                          : product.images[index];
                      return SafeNetworkImage(url: url);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.category.isNotEmpty)
                        Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: AppFontWeight.bold,
                            letterSpacing: 0.6,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: AppFontWeight.extraBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${product.price.toStringAsFixed(2)} \$',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: AppFontWeight.extraBold,
                              color: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Color(0xFFFFC107)),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: AppFontWeight.bold),
                          ),
                        ],
                      ),
                      if (product.description.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          product.description,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      context.read<CartCubit>().addToCart(product),
                  icon: Icon(
                    isInCart
                        ? Icons.shopping_bag
                        : Icons.shopping_bag_outlined,
                  ),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontWeight: AppFontWeight.extraBold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
