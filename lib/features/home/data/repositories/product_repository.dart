import 'package:dartz/dartz.dart';
import 'package:shop_easy/core/unified_api/failures.dart';
import 'package:shop_easy/core/unified_api/handling_exception_manager.dart';
import 'package:shop_easy/features/home/data/datasources/product_datasource.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';

class ProductRepository with HandlingExceptionManager {
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return handleError(
      tryCall: () async {
        final result = await ProductDatasource().getProducts();
        return Right(result);
      },
    );
  }
}
