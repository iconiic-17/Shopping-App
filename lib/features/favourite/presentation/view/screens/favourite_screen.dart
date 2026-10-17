import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/app_confirm_dialog.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/favourite/presentation/view/widget/favourite_empty_state.dart';
import 'package:shopping_app/features/favourite/presentation/view/widget/favourite_item.dart';
import 'package:shopping_app/features/favourite/presentation/view/widget/wishlist_category_chips.dart';
import 'package:shopping_app/features/favourite/presentation/view/widget/wishlist_header.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool _isGridView = true;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().getFavourites();
  }

  Future<void> _clearWishlist() async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Are you sure you want to Clear your Wishlist permanently?',
      message:
          'By doing this, all saved products will be removed permanently and you will not be able to recover them.',
    );
    if (confirmed && mounted) {
      await context.read<FavouriteCubit>().clearFavourites();
    }
  }

  List<String> _categories(List<ProductItemEntity> items) {
    final names = items
        .map((e) => e.category)
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList();
    return ['All', ...names];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        final cubit = context.read<FavouriteCubit>();
        final items = cubit.items;
        final categories = _categories(items);
        final selectedCategory = categories.contains(_selectedCategory)
            ? _selectedCategory
            : 'All';
        final filtered = selectedCategory == 'All'
            ? items
            : items
                .where(
                  (item) =>
                      item.category.toLowerCase() ==
                      selectedCategory.toLowerCase(),
                )
                .toList();

        return Column(
          children: [
            WishlistHeader(
              count: items.length,
              isGridView: _isGridView,
              onToggleView: () => setState(() => _isGridView = !_isGridView),
              onClear: _clearWishlist,
            ),
            if (items.isNotEmpty)
              WishlistCategoryChips(
                categories: categories,
                selected: selectedCategory,
                onSelected: (value) =>
                    setState(() => _selectedCategory = value),
              ),
            const SizedBox(height: 12),
            Expanded(
              child: state is FavouriteLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : state is FavouriteError
                  ? _FavouriteError(
                      message: state.message,
                      onRetry: cubit.getFavourites,
                    )
                  : items.isEmpty
                  ? const FavouriteEmptyState()
                  : filtered.isEmpty
                  ? const Center(child: Text('No items in this category'))
                  : _isGridView
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            mainAxisExtent: 310,
                          ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) => FavouriteItem(
                        product: filtered[index],
                        layout: ProductCardLayout.grid,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => FavouriteItem(
                        product: filtered[index],
                        layout: ProductCardLayout.list,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _FavouriteError extends StatelessWidget {
  const _FavouriteError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
