import 'package:dummyjson_api_workshop/models/products.dart';

import '../services/api_endpoints.dart';
import '../services/networking.dart';

class ProductRepository {
  Future<List<Products>> getAllProducts() async {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    return response['products']
        .map<Products>((json) => Products.fromJson(json))
        .toList();
  }

  Future<Products> getProductById(String id) async {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_PRODUCT_BY_ID(id),
    );
    return Products.fromJson(response);
  }
}
