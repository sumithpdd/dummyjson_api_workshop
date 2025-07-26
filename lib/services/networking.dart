import 'dart:developer';

import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:http/http.dart' as http;

class Networking {
  Future<String> getRequest({required String url}) async {
    final finalUrl = ApiEndpoints.baseUrl + url;
    final uri = Uri.parse(finalUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      log(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
