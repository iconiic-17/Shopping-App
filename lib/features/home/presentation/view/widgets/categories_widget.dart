import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/presentation/view/screens/products_by_category_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  static const _padding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is CProductsSuccess ||
            current is CProductsLoading ||
            current is CProductsError,
        builder: (context, state) {
          if (state is CProductsSuccess) {
            return ListView.separated(
              padding: _padding,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _CategoryItem(
                name: state.categortItemEntity[index].name,
                slug: state.categortItemEntity[index].slug,
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: state.categortItemEntity.length,
            );
          }
          if (state is CProductsError) {
            return Center(child: Text(state.error));
          }

          final entity = CategoryItemEntity();
          return Skeletonizer(
            enabled: true,
            child: ListView.separated(
              padding: _padding,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  _CategoryItem(name: entity.name, slug: entity.slug),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 10,
            ),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.name, required this.slug});

  final String name;
  final String slug;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: AppColors.black.withOpacity(0.06),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProductsByCategoryScreen(slug: slug, categoryName: name),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.black.withOpacity(0.12)),
          ),
          child: Text(
            name,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
