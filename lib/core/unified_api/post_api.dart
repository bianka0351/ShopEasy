import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'handling_request_exception.dart';

typedef FromJson<T> = T Function(String body);

class PostApi<T> with HandlingRequestException {
  final Uri uri;
  final Map<String, dynamic>? body;
  final FromJson fromJson;
  final bool isLogin;
  final Duration timeout;
  final Map<String, String>? additionalHeaders;

  const PostApi({
    required this.uri,
    this.body,
    required this.fromJson,
    this.additionalHeaders,
    this.isLogin = false,
    this.timeout = const Duration(seconds: 20),
  });

  Future<T> callRequest() async {
    try {
      var headers = {'Accept': 'application/json'};

      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders!);
      }

      // Check if there are files
      bool hasFile = body?.values.any((value) => value is File) ?? false;

      http.BaseRequest request;

      if (hasFile) {
        // Use MultipartRequest when files exist
        var multipartRequest = http.MultipartRequest('POST', uri);
        multipartRequest.headers.addAll(headers);

        // Add text data
        body?.forEach((key, value) {
          if (value is String) {
            multipartRequest.fields[key] = value;
          }
        });

        // Add files
        for (var entry in body!.entries) {
          if (entry.value is File) {
            File file = entry.value;
            multipartRequest.files.add(
              await http.MultipartFile.fromPath(entry.key, file.path),
            );
          }
        }

        request = multipartRequest;
      } else {
        // Using a normal Request without files
        request = http.Request('POST', uri);
        request.headers.addAll({
          'Content-Type': 'application/json',

          ...headers,
        });

        if (body != null) {
          (request as http.Request).body = jsonEncode(body);
        }
      }

      // send request
      http.StreamedResponse streamedResponse = await request.send().timeout(
        timeout,
      );

      log(body.toString(), name: "request body");

      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body == 'true') {
          return true as T;
        } else if (response.body == 'false') {
          return false as T;
        }
        return fromJson(response.body);
      } else {
        throw getException(response: response);
      }
    } on HttpException {
      log('http exception', name: 'RequestManager post function');
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log('socket exception', name: 'RequestManager post function');
      rethrow;
    } catch (e) {
      log(e.toString(), name: 'RequestManager post function');
      rethrow;
    }
  }
}
