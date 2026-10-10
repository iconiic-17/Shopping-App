import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is CProductsSuccess ||
            current is CProductsLoading ||
            current is CProductsError,
        builder: (context, state) {
          if (state is CProductsSuccess) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _CategoryItem(
                name: state.categortItemEntity[index].name,
                slug: state.categortItemEntity[index].slug,
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: state.categortItemEntity.length,
            );
          }
          if (state is CProductsError) {
            return Center(child: Text(state.error));
          }

          var entity = CategoryItemEntity();
          return Skeletonizer(
            enabled: true,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  _CategoryItem(name: entity.name, slug: entity.slug),
              separatorBuilder: (context, index) => SizedBox(width: 10),
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
    return Container(
      padding: EdgeInsets.all(8),
      //margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black),
        color: Colors.transparent,
      ),
      child: Text(name, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
