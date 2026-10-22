import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/app_product_card.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_by_category_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_by_category_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  final String slug;
  final String categoryName;

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    mainAxisExtent: 320,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.instance<ProductsByCategoryCubit>()..getProducts(slug),
      child: Scaffold(
        appBar: AppBar(title: Text(categoryName)),
        body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
          builder: (context, state) {
            if (state is PBCSuccess) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: _gridDelegate,
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return AppProductCard(product: state.products[index]);
                },
              );
            }

            if (state is PBCEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 64),
                    SizedBox(height: 12),
                    Text('No products in this category'),
                  ],
                ),
              );
            }

            if (state is PBCError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ProductsByCategoryCubit>()
                          .getProducts(slug),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Skeletonizer(
              enabled: true,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: _gridDelegate,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final entity = ProductItemEntity();
                  return ProductItemCard(
                    onTap: () {},
                    title: entity.title,
                    discount: entity.discountPercentage,
                    price: entity.price,
                    rating: entity.rating,
                    image: entity.images.isNotEmpty ? entity.images.first : '',
                    favoriteOnTap: const Icon(Icons.favorite),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
