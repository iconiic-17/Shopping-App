import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class FavouriteEmptyState extends StatelessWidget {
  const FavouriteEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 72, color: AppColors.textHint),
          SizedBox(height: 12),
          Text(
            'No favourite items yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          Text(
            'Tap the heart on a product to save it here',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
