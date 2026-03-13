import 'dart:convert';
import 'package:http/http.dart' as http;

class CartDatasource {
  Future<bool> addToCart({
    required int productId,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/carts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": 1,
        "date": DateTime.now().toIso8601String(),
        "products": [
          {"productId": productId, "quantity": quantity},
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    throw Exception("Failed to add to cart");
  }
}
