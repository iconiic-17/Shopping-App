import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widget/custtom_button.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/presentation/view_model/product_details_cubit.dart';
import 'package:shopping_app/features/details/presentation/view_model/product_details_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ProductDetailsCubit>()..getDetails(productId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) => switch (state) {
            ProductDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(foregroundColor: AppColors.orangeLight),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.product});
  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                _ImageSlider(images: product.images),
                Text(product.title, style: textTheme.bodyLarge),
                _PriceRow(product: product),
                Text('Description', style: textTheme.labelLarge),
                Text(
                  product.description,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: AppColors.greyDark,
                  ),
                ),
                _ReviewsSection(reviews: product.reviews),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Add to Cart',
              onPressed: () {}, // UI only حسب الـ task
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageSlider extends StatefulWidget {
  const _ImageSlider({required this.images});
  final List<String> images;

  @override
  State<_ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<_ImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    if (images.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 60,
            color: AppColors.greyDark,
          ),
        ),
      );
    }

    return Column(
      spacing: 8,
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            enableInfiniteScroll: images.length > 1,
            onPageChanged: (index, _) => setState(() => _current = index),
          ),
          itemBuilder: (_, index, __) => Image.network(
            images[index],
            fit: BoxFit.contain,
            width: double.infinity,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.broken_image,
              size: 60,
              color: AppColors.greyDark,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _current ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == _current
                    ? AppColors.primary
                    : AppColors.greyDark.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.product});
  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 12,
      children: [
        Flexible(
          child: Text(
            'EGP ${product.price.toStringAsFixed(2)}',
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelLarge?.copyWith(fontSize: 20),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Disc: ${product.discountPercentage.toStringAsFixed(0)}%',
            style: textTheme.labelMedium?.copyWith(color: AppColors.red),
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, color: AppColors.primaryOrange, size: 20),
        Text(product.rating.toStringAsFixed(1), style: textTheme.labelMedium),
      ],
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({required this.reviews});
  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text('Reviews (${reviews.length})', style: textTheme.labelLarge),
        if (reviews.isEmpty)
          Text('No reviews yet', style: textTheme.labelMedium),
        for (final review in reviews)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.reviewerName,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: AppColors.primaryOrange,
                      size: 18,
                    ),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: textTheme.labelMedium,
                    ),
                  ],
                ),
                Text(
                  review.comment,
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
