import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.onClear, required this.canClear});

  final VoidCallback onClear;
  final bool canClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your Cart',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: AppFontWeight.extraBold,
              ),
            ),
          ),
          IconButton(
            onPressed: canClear ? onClear : null,
            icon: Icon(
              Icons.delete_outline,
              color: canClear
                  ? theme.colorScheme.onSurface
                  : theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
