import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HProductsSuccess) {
          return GridView.builder(
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
          );
        }
        if (state is HProductsError) {
          return Center(child: Text(state.error));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

final String image =
    "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp";
