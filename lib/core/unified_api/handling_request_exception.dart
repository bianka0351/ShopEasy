//Handling HTTP errors based on the Status Code after receiving the response
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_easy/core/unified_api/exceptions.dart';

mixin HandlingRequestException {
  Exception getException({required Response response}) {
    String message = 'An unexpected error occurred';

    try {
      final decodedBody = jsonDecode(response.body);
      if (decodedBody is Map<String, dynamic> &&
          decodedBody.containsKey('message') &&
          decodedBody['message'] is String) {
        message = decodedBody['message'];
      }
    } catch (_) {
      message = 'Invalid error response';
    }

    // handle HTTP status codes
    switch (response.statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
      case 403:
        return AuthException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 429:
        return ServerException(message: "Too many requests. Slow down.");
      case 500:
        return ServerException(message: message);
      case 502:
      case 503:
        return ServerException(message: "Service is temporarily unavailable.");

      default:
        return UnknownException(message: message);
    }
  }
}
