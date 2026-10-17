import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/cart/presentation/view/widget/cart_checkout_bar.dart';

void main() {
  testWidgets('CartCheckoutBar renders total price and handles checkout callback',
      (WidgetTester tester) async {
    bool checkoutTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: CartCheckoutBar(
            totalPrice: 99.99,
            onCheckout: () {
              checkoutTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('\$99.99'), findsNWidgets(2));
    expect(find.text('Proceed to Checkout  →'), findsOneWidget);

    await tester.tap(find.text('Proceed to Checkout  →'));
    await tester.pump();

    expect(checkoutTapped, isTrue);
  });
}
