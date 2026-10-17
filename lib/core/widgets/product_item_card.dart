import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';

enum ProductCardLayout { grid, list }

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.onTap,
    this.favoriteOnTap,
    this.onFavoriteTap,
    this.addToCartOnTap,
    required this.title,
    required this.discount,
    required this.price,
    required this.rating,
    required this.image,
    this.category = '',
    this.isFavorite = false,
    this.isInCart = false,
    this.layout = ProductCardLayout.grid,
  });

  final VoidCallback? addToCartOnTap;
  final bool isInCart;
  final Widget? favoriteOnTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final String title;
  final String category;
  final double discount;
  final double price;
  final double rating;
  final String image;
  final VoidCallback? onTap;
  final ProductCardLayout layout;

  double get _oldPrice {
    if (discount <= 0) return price;
    return price / (1 - (discount / 100));
  }

  String? get _badge {
    if (discount >= 20) return '-${discount.toStringAsFixed(0)}%';
    if (discount > 0) return 'SALE';
    if (rating >= 4.8) return 'TOP';
    if (rating >= 4.5) return 'NEW';
    return 'HOT';
  }

  Widget get _heart {
    if (onFavoriteTap != null) {
      return _FavoriteButton(isFavorite: isFavorite, onTap: onFavoriteTap);
    }
    return favoriteOnTap ?? const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return layout == ProductCardLayout.list
        ? _ListCard(parent: this)
        : _GridCard(parent: this);
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({required this.parent});

  final ProductItemCard parent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: parent.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SafeNetworkImage(url: parent.image),
                      ),
                    ),
                  ),
                  if (parent._badge != null)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: _Badge(text: parent._badge!),
                    ),
                  Positioned(top: 12, right: 12, child: parent._heart),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          parent.category.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.4,
                            color: AppColors.textSecondary,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        parent.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: AppFontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    parent.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: AppFontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${parent.price.toStringAsFixed(0)} \$',
                        style: const TextStyle(
                          fontWeight: AppFontWeight.extraBold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      if (parent.discount > 0) ...[
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '${parent._oldPrice.toStringAsFixed(0)} \$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textHint,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: parent.addToCartOnTap,
                    child: _AddToCartButton(
                      onTap: parent.addToCartOnTap,
                      isInCart: parent.isInCart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({required this.parent});

  final ProductItemCard parent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: parent.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 92,
                    height: 92,
                    child: SafeNetworkImage(url: parent.image),
                  ),
                ),
                if (parent._badge != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: _Badge(text: parent._badge!),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          parent.category.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.4,
                            color: AppColors.textSecondary,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                      ),
                      parent._heart,
                    ],
                  ),
                  Text(
                    parent.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: AppFontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${parent.price.toStringAsFixed(0)} \$',
                        style: const TextStyle(
                          fontWeight: AppFontWeight.extraBold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      if (parent.discount > 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          '${parent._oldPrice.toStringAsFixed(0)} \$',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      const Spacer(),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        parent.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: AppFontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: parent.addToCartOnTap,
                    child: _AddToCartButton(
                      onTap: parent.addToCartOnTap,
                      isInCart: parent.isInCart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, this.onTap});

  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.16),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? const Color(0xFFFF2D55) : AppColors.textSecondary,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 10,
          fontWeight: AppFontWeight.extraBold,
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({this.onTap, this.isInCart = false});

  final VoidCallback? onTap;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          isInCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
          size: 16,
        ),
        label: const Text('Add to Cart'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          textStyle: const TextStyle(fontSize: 12, fontWeight: AppFontWeight.bold),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
