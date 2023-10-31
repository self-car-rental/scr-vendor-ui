class ApiConfig {
  ApiConfig._();

  static const token =
      'a78181ca9b28fa2f4edadf9cb7164205f3063f78a6d2ff68121241dec0b2db81';
  static const String baseUrl = 'https://gorest.co.in/public/v2';
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const String users = '/users';
  static const header = {
    'Authorization': 'Bearer $token',
    'content-Type': 'application/json',
  };
}
