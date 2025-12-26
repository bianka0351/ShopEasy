class Validator {
  static bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool arePasswordsMatching(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool isNotEmpty(String value) => value.trim().isNotEmpty;
}
