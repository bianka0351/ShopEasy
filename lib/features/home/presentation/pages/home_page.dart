import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/widgets/custom_error_message.dart';
import 'package:shop_easy/core/widgets/custom_loading.dart';
import 'package:shop_easy/core/widgets/custom_search_bar.dart';
import 'package:shop_easy/features/home/bloc/product_bloc.dart';
import 'package:shop_easy/features/home/presentation/widgets/product_card.dart';
import 'package:shop_easy/features/home/presentation/widgets/promo_banner_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE6EA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFE6EA),
        title: Text(
          'ShopEasy',
          style: AppFonts.notoBold(color: Color(0xFFD64545), fontSize: 24),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomSearchBar(
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProductsEvent(value));
              },

              controller: TextEditingController(),
              hintText: 'Search',
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CustomLoading());
          }
          if (state is ProductError) {
            return CustomErrorMessage(
              message: state.message,
              onRetry: () {
                context.read<ProductBloc>().add(LoadProductsEvent());
              },
            );
          }
          if (state is ProductLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PromoBannerWidget(),
                  const SizedBox(height: 24),
                  Text(
                    'Popular Products',
                    style: AppFonts.notoBold(fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: .7,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (_, index) {
                      return ProductCard(product: state.products[index]);
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
