class CustomAuthException implements Exception {
  final String error;

  CustomAuthException(this.error);
}
