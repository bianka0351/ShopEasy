import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/services/hive_boxes.dart';
import 'package:shop_easy/features/cart/data/models/cart_item_model.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    void addToCart(CartItem item) {
      final box = Hive.box<CartItem>(HiveBoxes.cart);
      box.add(item);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: Column(
        children: [
          /// IMAGE HEADER
          SizedBox(height: 20),
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(product.image, fit: BoxFit.contain),
              ),

              /// BACK BUTTON
              SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),

          /// CONTENT
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// BRAND
                  if (product.brand != null)
                    Text(
                      product.brand!,
                      style: AppFonts.notoRegular(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                  const SizedBox(height: 6),

                  /// TITLE
                  Text(product.title, style: AppFonts.notoBold(fontSize: 22)),

                  const SizedBox(height: 10),

                  /// RATING + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: AppFonts.notoMedium(fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppFonts.notoBold(
                          fontSize: 22,
                          color: const Color(0xFFD64545),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION
                  Text('Description', style: AppFonts.notoBold(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: AppFonts.notoRegular(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),

                  const Spacer(),

                  /// ADD TO CART BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD64545),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        final cartItem = CartItem(
                          name: product.title,
                          price: product.price,
                          imageUrl: product.image,
                        );

                        addToCart(cartItem);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')),
                        );
                      },
                      child: Text(
                        'Add to Cart',
                        style: AppFonts.notoMedium(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
