import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_easy/core/services/hive_boxes.dart';
import 'package:shop_easy/features/auth/presentation/widgets/main_button_widget.dart';
import '../../data/models/cart_item_model.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CartItem>(HiveBoxes.cart),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFFFE6EA),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cartBox = Hive.box<CartItem>(HiveBoxes.cart);

        double subtotal = cartBox.values.fold(
          0.0,
          (sum, item) => sum + item.price,
        );

        return Scaffold(
          backgroundColor: const Color(0xFFFFE6EA),

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'My Cart',
              style: AppFonts.notoBold(
                fontSize: 24,
                color: const Color(0xFFD64545),
              ),
            ),
          ),
          body: ValueListenableBuilder(
            valueListenable: cartBox.listenable(),
            builder: (context, Box<CartItem> box, _) {
              if (box.values.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }

              subtotal = box.values.fold(0.0, (sum, item) => sum + item.price);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final item = box.getAt(index)!;
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Image.network(item.imageUrl, width: 50),
                            title: Text(
                              item.name,
                              style: AppFonts.notoMedium(fontSize: 16),
                            ),
                            subtitle: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: AppFonts.notoRegular(fontSize: 14),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFD64545),
                              ),
                              onPressed: () {
                                item.delete();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal:',
                              style: AppFonts.notoMedium(fontSize: 16),
                            ),
                            Text(
                              '\$${subtotal.toStringAsFixed(2)}',
                              style: AppFonts.notoBold(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MainButtonWidget(text: 'Checkout', onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
