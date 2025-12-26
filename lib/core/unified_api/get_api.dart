import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shop_easy/core/unified_api/failures.dart';
import 'package:shop_easy/core/unified_api/handling_request_exception.dart';

class GetApi<T> with HandlingRequestException {
  final String url;
  final T Function(String) fromJson;
  final Map<String, String>? headers;

  GetApi({required this.url, required this.fromJson, this.headers});

  Future<T> call() async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception e = getException(response: response);
        log("API Error: ${e.toString()}");
        throw ServerFailure(message: e.toString());
      }
    } on Exception catch (e) {
      log("Unexpected error: $e");
      rethrow;
    }
  }
}
