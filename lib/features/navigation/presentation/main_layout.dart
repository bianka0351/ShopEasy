import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/core/widgets/custom_bottom_nav.dart';
import 'package:shop_easy/features/cart/presentation/pages/cart_page.dart';
import 'package:shop_easy/features/home/presentation/pages/home_page.dart';
import 'package:shop_easy/features/profile/presentation/pages/profile_page.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../cubit/bottom_nav_state.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        final pages = [const HomePage(), const CartPage(), const ProfilePage()];

        return Scaffold(
          body: pages[state.index],
          bottomNavigationBar: CustomBottomNav(
            currentIndex: state.index,
            onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
          ),
        );
      },
    );
  }
}
