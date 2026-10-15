import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.onClear, required this.canClear});

  final VoidCallback onClear;
  final bool canClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          if (Navigator.canPop(context))
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            )
          else
            const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Your Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ),
          IconButton(
            onPressed: canClear ? onClear : null,
            icon: Icon(
              Icons.delete_outline,
              color: canClear ? AppColors.textPrimary : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
