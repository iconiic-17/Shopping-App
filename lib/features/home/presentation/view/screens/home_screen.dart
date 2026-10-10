import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        CategoriesWidget(),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is HProductsSuccess ||
              current is HProductsLoading ||
              current is HProductsError,
          builder: (context, state) {
            if (state is HProductsSuccess) {
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 18,
                    childAspectRatio: 163 / 288,
                  ),
                  itemCount: state.productItemEntity.length,
                  itemBuilder: (context, index) {
                    final item = state.productItemEntity[index];
                    return ProductItemCard(
                      onTap: () {},
                      title: item.title,
                      discount: item.discountPercentage,
                      price: item.price,
                      rating: item.rating,
                      image: item.images.isNotEmpty ? item.images.first : '',
                      favoriteOnTap: const Icon(Icons.favorite),
                    );
                  },
                ),
              );
            }
            if (state is HProductsError) {
              return Center(child: Text(state.error));
            }

            return Expanded(
              child: Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 18,
                    childAspectRatio: 163 / 288,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    var entity = ProductItemEntity();
                    return ProductItemCard(
                      onTap: () {},
                      title: entity.title,
                      discount: entity.discountPercentage,
                      price: entity.price,
                      rating: entity.rating,
                      image: entity.images.first,
                      favoriteOnTap: const Icon(Icons.favorite),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
