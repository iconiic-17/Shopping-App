import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/features/account/presentation/view/screens/account_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_state.dart';
import 'package:shopping_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';

class AppSectionView extends StatefulWidget {
  const AppSectionView({super.key});

  @override
  State<AppSectionView> createState() => _AppSectionViewState();
}

class _AppSectionViewState extends State<AppSectionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CartCubit>().getCart();
      context.read<FavouriteCubit>().getFavourites();
    });
  }

  late final List<Widget> _tabs = [
    BlocProvider<HomeCubit>(
      create: (context) => serviceLocator<HomeCubit>()..intent(HIntentCalls()),
      child: const HomeScreen(),
    ),
    const CartScreen(),
    const FavouriteScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.offWhite,
            body: SafeArea(
              child: IndexedStack(index: state.currentIndex, children: _tabs),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<AppSectionCubit>().changeTab(index);
                if (index == 1) context.read<CartCubit>().getCart();
                if (index == 2) {
                  context.read<FavouriteCubit>().getFavourites();
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.semiBold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.regular,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  activeIcon: Icon(Icons.shopping_bag),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Account',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
