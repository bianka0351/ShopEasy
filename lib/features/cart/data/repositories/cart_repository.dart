import 'package:dartz/dartz.dart';
import 'package:shop_easy/core/unified_api/failures.dart';
import 'package:shop_easy/core/unified_api/handling_exception_manager.dart';

import '../datasources/cart_datasource.dart';

class CartRepository with HandlingExceptionManager {
  Future<Either<Failure, bool>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    return handleError(
      tryCall: () async {
        final result = await CartDatasource().addToCart(
          productId: productId,
          quantity: quantity,
        );

        return Right(result);
      },
    );
  }
}
