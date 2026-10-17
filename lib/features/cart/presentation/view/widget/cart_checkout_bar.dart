import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  final double totalPrice;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _Row(label: 'Subtotal', value: '\$${totalPrice.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          const _Row(
            label: 'Shipping',
            value: 'Free',
            valueColor: AppColors.success,
          ),
          const Divider(height: 24),
          _Row(
            label: 'Total',
            value: '\$${totalPrice.toStringAsFixed(2)}',
            isBold: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Proceed to Checkout  →',
                style: textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final style = isBold
        ? textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          )
        : textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          );

    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text(value, style: style?.copyWith(color: valueColor)),
      ],
    );
  }
}
