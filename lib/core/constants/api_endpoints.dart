abstract class ApiEndpoints {
  // Base API url string..
  static final String _baseUrlString = "https://dummyjson.com/";

  static String _baseUrl(String api) => "$_baseUrlString$api";

  static String get urlPRODUCTS => _baseUrl("products");
}
