abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = "Server failure"});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No internet connection"});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = "Authentication failed"});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = "Unknown failure"});
}
