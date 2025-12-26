// core/hive_boxes.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_easy/features/cart/data/models/cart_item_model.dart';

class HiveBoxes {
  static String cart = 'cart_box';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>(cart);
  }
}
