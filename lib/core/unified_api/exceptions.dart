abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  BadRequestException({required String message}) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException({required String message}) : super(message);
}

class UnknownException extends AppException {
  UnknownException({required String message}) : super(message);
}

class ServerException extends AppException {
  ServerException({required String message}) : super(message);
}

class NetworkException extends AppException {
  NetworkException({required String message}) : super(message);
}

class AuthException extends AppException {
  AuthException({required String message}) : super(message);
}
