class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  static const String users = '/users';
  static String userById(int? userId) => '$users/$userId';
}
