import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/widgets/custom_error_message.dart';
import 'package:shop_easy/core/widgets/custom_loading.dart';
import 'package:shop_easy/core/widgets/custom_search_bar.dart';
import 'package:shop_easy/features/home/bloc/product_bloc.dart';
import 'package:shop_easy/features/home/presentation/widgets/product_card.dart';
import 'package:shop_easy/features/home/presentation/widgets/promo_banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE6EA),
        title: Text(
          'ShopEasy',
          style: AppFonts.notoBold(
            color: const Color(0xFFD64545),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomSearchBar(
              controller: TextEditingController(),
              hintText: 'Search',
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProductsEvent(value));
              },
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
              onRetry: () =>
                  context.read<ProductBloc>().add(LoadProductsEvent()),
            );
          }
          if (state is ProductLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PromoBannerWidget(),
                  const SizedBox(height: 10),
                  Text('Categories', style: AppFonts.notoBold(fontSize: 22)),
                  const SizedBox(height: 10),
                  _buildCategoryList(state),
                  const SizedBox(height: 10),
                  Text(
                    'Trending Products',
                    style: AppFonts.notoBold(fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  _buildProductGrid(state.displayedProducts),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCategoryList(ProductLoaded state) {
    final categories = state.categories;
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == state.selectedCategory;
          return GestureDetector(
            onTap: () {
              context.read<ProductBloc>().add(
                FilterByCategoryEvent(category == 'All' ? null : category),
              );
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: isSelected
                      ? const Color(0xFFD64545)
                      : const Color(0xFFD64545).withValues(alpha: 0.5),
                  child: Icon(
                    _getCategoryIcon(category),
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(category, style: const TextStyle(fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(List products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (_, index) => ProductCard(product: products[index]),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "men_s_clothing":
        return Icons.man;
      case "women_s_clothing":
        return Icons.woman;
      case "jewelery":
        return Icons.watch;
      case "electronics":
        return Icons.devices;
      default:
        return Icons.category;
    }
  }
}
