import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/details/presentation/view/screen/product_details_screen.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';
import 'package:shopping_app/features/search/presentation/view/widget/home_search_bar.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 30,
  mainAxisSpacing: 18,
  childAspectRatio: 163 / 288,
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SearchCubit>(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        const HomeSearchBar(),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return IndexedStack(
                index: state is SearchInitial ? 0 : 1,
                children: [
                  const _NormalHomeContent(),
                  _SearchResults(state: state),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NormalHomeContent extends StatelessWidget {
  const _NormalHomeContent();

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
                child: _ProductsGrid(products: state.productItemEntity),
              );
            }
            if (state is HProductsError) {
              return Center(child: Text(state.error));
            }
            return const Expanded(child: _SkeletonGrid());
          },
        ),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.state});
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      SearchLoading() => const _SkeletonGrid(),
      SearchSuccess(:final products) => _ProductsGrid(products: products),
      SearchEmpty() => const Center(
        child: Text('No products found matching your search'),
      ),
      SearchError(:final error) => Center(child: Text(error)),
      SearchInitial() => const SizedBox.shrink(),
    };
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({required this.products});
  final List<ProductItemEntity> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: _gridDelegate,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];
        return ProductItemCard(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(productId: item.id),
            ),
          ),
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
}

class _SkeletonGrid extends StatelessWidget {
  const _SkeletonGrid();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: _gridDelegate,
        itemCount: 10,
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
  }
}
