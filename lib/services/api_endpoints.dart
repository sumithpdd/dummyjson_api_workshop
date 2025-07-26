// ignore_for_file: constant_identifier_names

class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';
  static const String POST_LOGIN = '/auth/login';
  static const String GET_ALL_PRODUCTS = '/products';

  static String GET_PRODUCT_BY_ID(String id) => '/products/$id';
}
