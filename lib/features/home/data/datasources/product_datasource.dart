import 'package:shop_easy/core/unified_api/get_api.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';

class ProductDatasource {
  Future<List<ProductModel>> getProducts() async {
    final getApi = GetApi(
      url: 'https://dummyjson.com/products',
      fromJson: productModelFromJson,
    );

    return await getApi.call();
  }
}
