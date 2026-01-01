abstract class ApiEndpoints {
  // Base API url string..
  static final String _baseUrlString = "https://api.escuelajs.co/api/v1/";

  static String _baseUrl(String api) => "$_baseUrlString$api";

  static String get urlPRODUCTS => _baseUrl("products");
}
