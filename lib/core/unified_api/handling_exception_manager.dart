//Handling errors during request execution
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:shop_easy/core/unified_api/exceptions.dart';
import 'package:shop_easy/core/unified_api/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> handleError<T>({
    required Future<Right<Failure, T>> Function() tryCall,
  }) async {
    try {
      final result = await tryCall();
      return result;
    } on ServerException catch (e) {
      log('ServerException: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      log('NetworkException: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on AuthException catch (e) {
      log('AuthException: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on SocketException catch (e) {
      log('No Internet Connection: : ${e.message}');
      return Left(
        NetworkFailure(message: "No internet connection. Please try again."),
      );
    } on TimeoutException {
      log('Request Timeout');
      return Left(
        NetworkFailure(message: "The request timed out. Please try again."),
      );
    } catch (e) {
      log('Unknown Exception: $e');

      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
