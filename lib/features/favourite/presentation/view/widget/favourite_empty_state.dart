import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';

class FavouriteEmptyState extends StatelessWidget {
  const FavouriteEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 72, color: theme.disabledColor),
            const SizedBox(height: 12),
            Text(
              'No favourite items yet',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: AppFontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the heart on a product to save it here',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AppSectionCubit>().changeTab(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
