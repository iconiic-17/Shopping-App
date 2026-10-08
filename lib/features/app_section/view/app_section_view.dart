import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/account/presentation/view/screens/account_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_state.dart';
import 'package:shopping_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';

class AppSectionView extends StatelessWidget {
  const AppSectionView({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: _tabs,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) =>
                  context.read<AppSectionCubit>().changeTab(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
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
