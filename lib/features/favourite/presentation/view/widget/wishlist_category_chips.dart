import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';

class WishlistCategoryChips extends StatelessWidget {
  const WishlistCategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final name = categories[index];
          final isSelected = name == selected;
          return GestureDetector(
            onTap: () => onSelected(name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                ),
              ),
              child: Text(
                name,
                style: textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
