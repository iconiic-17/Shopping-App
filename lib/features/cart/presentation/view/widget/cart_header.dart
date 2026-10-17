import 'package:flutter/material.dart';

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
          if (Navigator.canPop(context))
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your Cart',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
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
