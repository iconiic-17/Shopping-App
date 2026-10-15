import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class WishlistHeader extends StatelessWidget {
  const WishlistHeader({
    super.key,
    required this.count,
    required this.isGridView,
    required this.onToggleView,
    required this.onClear,
  });

  final int count;
  final bool isGridView;
  final VoidCallback onToggleView;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          const Text(
            'My Wishlist',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE1C6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onToggleView,
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view_rounded),
          ),
          IconButton(
            onPressed: count > 0 ? onClear : null,
            icon: Icon(
              Icons.delete_outline,
              color: count > 0 ? AppColors.textPrimary : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
