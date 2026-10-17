import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';

class FavouriteEmptyState extends StatelessWidget {
  const FavouriteEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 72,
            color: theme.disabledColor,
          ),
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
        ],
      ),
    );
  }
}
