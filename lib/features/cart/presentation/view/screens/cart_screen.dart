import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/app_confirm_dialog.dart';
import 'package:shopping_app/core/widgets/app_snackbar.dart';
import 'package:shopping_app/features/cart/presentation/view/widget/cart_checkout_bar.dart';
import 'package:shopping_app/features/cart/presentation/view/widget/cart_empty_state.dart';
import 'package:shopping_app/features/cart/presentation/view/widget/cart_header.dart';
import 'package:shopping_app/features/cart/presentation/view/widget/cart_item.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  Future<void> _clearCart() async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Are you sure you want to Clear your Cart permanently?',
      message:
          'By doing this, all saved products will be removed permanently and you will not be able to recover them.',
    );
    if (confirmed && mounted) {
      await context.read<CartCubit>().clearCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final items = cubit.items;
        final total = cubit.totalPrice;

        return Column(
          children: [
            CartHeader(onClear: _clearCart, canClear: items.isNotEmpty),
            Expanded(
              child: state is CartLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : state is CartError
                  ? _CartError(message: state.message, onRetry: cubit.getCart)
                  : items.isEmpty
                  ? const CartEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return CartItemWidget(
                          item: item,
                          onDelete: () => cubit.deleteItem(item.id),
                          onIncrement: () => cubit.changeQuantity(item.id, 1),
                          onDecrement: () => cubit.changeQuantity(item.id, -1),
                        );
                      },
                    ),
            ),
            if (items.isNotEmpty)
              CartCheckoutBar(
                totalPrice: total,
                onCheckout: () {
                  showAppSnackBar(
                    context,
                    message: 'Checkout is not available yet',
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _CartError extends StatelessWidget {
  const _CartError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
