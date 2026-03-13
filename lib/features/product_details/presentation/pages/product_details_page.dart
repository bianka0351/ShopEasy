import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/features/cart/bloc/cart_bloc.dart';

import 'package:shop_easy/features/home/data/models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),

      body: Column(
        children: [
          const SizedBox(height: 30),

          /// PRODUCT IMAGE
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    product.image,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),

              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartLoaded) {
                    if (state.error != null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error!)));
                    }

                    if (state.addToCartSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to cart")),
                      );
                    }
                  }
                },

                builder: (context, state) {
                  int quantity = 1;

                  if (state is CartLoaded) {
                    quantity = state.quantity;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// CATEGORY
                        Text(
                          product.category.name,
                          style: AppFonts.notoRegular(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// TITLE
                        Text(
                          product.title,
                          style: AppFonts.notoBold(fontSize: 20),
                        ),

                        const SizedBox(height: 12),

                        /// RATING + PRICE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  product.rating.rate.toString(),
                                  style: AppFonts.notoMedium(fontSize: 18),
                                ),
                              ],
                            ),

                            Text(
                              "\$${product.price}",
                              style: AppFonts.notoBold(
                                fontSize: 22,
                                color: const Color(0xFFD64545),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// DESCRIPTION
                        Text(
                          "Description",
                          style: AppFonts.notoBold(fontSize: 18),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          product.description,
                          style: AppFonts.notoRegular(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// QUANTITY
                        Row(
                          children: [
                            Text(
                              "Quantity",
                              style: AppFonts.notoBold(fontSize: 16),
                            ),

                            const SizedBox(width: 20),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        DecreaseQuantity(),
                                      );
                                    },
                                  ),

                                  Text(
                                    quantity.toString(),
                                    style: AppFonts.notoMedium(fontSize: 16),
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        IncreaseQuantity(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      /// ADD TO CART BUTTON
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int quantity = 1;
          bool isLoading = false;

          if (state is CartLoaded) {
            quantity = state.quantity;
            isLoading = state.isLoading;
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            color: Colors.white,

            child: SizedBox(
              height: 56,
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD64545),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: isLoading
                    ? null
                    : () {
                        context.read<CartBloc>().add(
                          AddToCartEvent(productId: product.id),
                        );
                      },

                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Add to Cart',
                        style: AppFonts.notoMedium(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
