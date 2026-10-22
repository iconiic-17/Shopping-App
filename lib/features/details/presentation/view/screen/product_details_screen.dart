import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widget/custtom_button.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/presentation/view_model/product_details_cubit.dart';
import 'package:shopping_app/features/details/presentation/view_model/product_details_state.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ProductDetailsCubit>()..getDetails(productId),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: AppColors.textPrimary,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.lightGray.withValues(alpha: 0.5),
                shape: const CircleBorder(),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Product Details',
            style: AppTextStyles.font18Medium.copyWith(
              fontWeight: AppFontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) => switch (state) {
            ProductDetailsLoading() => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            ProductDetailsError(:final error) => _ErrorView(
              message: error,
              onRetry: () =>
                  context.read<ProductDetailsCubit>().getDetails(productId),
            ),
            ProductDetailsSuccess(:final product) => _DetailsBody(
              product: product,
            ),
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.product});
  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductGallery(product: product),
                const SizedBox(height: 20),
                _ProductHeader(product: product),
                const SizedBox(height: 20),
                _DescriptionSection(description: product.description),
                const SizedBox(height: 24),
                _ReviewsSection(reviews: product.reviews),
              ],
            ),
          ),
        ),
        _BottomCartBar(product: product),
      ],
    );
  }
}

class _ProductGallery extends StatefulWidget {
  const _ProductGallery({required this.product});
  final ProductDetailsEntity product;

  @override
  State<_ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<_ProductGallery> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;
    final isFavorite = context.select(
      (FavouriteCubit cubit) => cubit.isFavourite(widget.product.id),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                if (images.isEmpty)
                  const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: AppColors.textHint,
                    ),
                  )
                else
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: 320,
                      viewportFraction: 1,
                      enableInfiniteScroll: images.length > 1,
                      onPageChanged: (index, _) =>
                          setState(() => _currentIndex = index),
                    ),
                    itemBuilder: (context, index, _) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: SafeNetworkImage(
                          url: images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                if (widget.product.discountPercentage > 0)
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.red.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '-${widget.product.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: AppFontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 14,
                  right: 14,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context
                          .read<FavouriteCubit>()
                          .toggleFavourite(widget.product.toProductItem()),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? AppColors.error
                              : AppColors.textPrimary,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),

                if (images.length > 1)
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentIndex == index ? 20 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? AppColors.primary
                                : AppColors.lightGray,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        if (images.length > 1) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                    setState(() => _currentIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: isSelected ? 2.0 : 1.2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SafeNetworkImage(
                        url: images[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({required this.product});
  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.category.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: AppFontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'In Stock',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: AppFontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.primaryOrange,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviews.length})',
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.title,
          style: AppTextStyles.font22Bold.copyWith(
            color: AppColors.textPrimary,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.description_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Description',
              style: AppTextStyles.font16SemiBold.copyWith(
                color: AppColors.textPrimary,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1.2),
          ),
          child: Text(
            description.isEmpty ? 'No description available.' : description,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.greyDark,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({required this.reviews});
  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.rate_review_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Customer Reviews',
              style: AppTextStyles.font16SemiBold.copyWith(
                color: AppColors.textPrimary,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${reviews.length}',
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: AppFontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (reviews.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1.2),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.reviews_outlined,
                  size: 36,
                  color: AppColors.textHint,
                ),
                const SizedBox(height: 8),
                Text(
                  'No reviews yet for this product',
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 145,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final review = reviews[index];
                final initial = review.reviewerName.trim().isNotEmpty
                    ? review.reviewerName.trim()[0].toUpperCase()
                    : '?';

                return Container(
                  width: 250,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: AppFontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              review.reviewerName,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.font14SemiBold.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryOrange,
                                  size: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  review.rating.toStringAsFixed(1),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          review.comment.isEmpty
                              ? 'No written feedback'
                              : review.comment,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font14Regular.copyWith(
                            fontSize: 13,
                            color: AppColors.greyDark,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _BottomCartBar extends StatelessWidget {
  const _BottomCartBar({required this.product});
  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.discountPercentage > 0;
    final originalPrice = hasDiscount
        ? product.price / (1 - (product.discountPercentage / 100))
        : product.price;

    final isInCart = context.select(
      (CartCubit cubit) => cubit.isInCart(product.id),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '-${product.discountPercentage.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: AppFontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'EGP ${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.font22Bold.copyWith(
                            color: AppColors.primary,
                            fontWeight: AppFontWeight.extraBold,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 6),
                          Text(
                            'EGP ${originalPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textHint,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 5,
              child: CustomButton(
                text: isInCart ? 'In Cart (+1)' : 'Add to Cart',
                onPressed: () {
                  context.read<CartCubit>().addToCart(product.toProductItem());
                },
                height: 50,
                borderRadius: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
