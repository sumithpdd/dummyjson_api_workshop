import 'dart:convert';
import 'dart:developer';

import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:http/http.dart' as http;

class Networking {
  static const commonHeaders = {'Content-Type': 'application/json'};

  /// Makes a GET request and returns the response as a Map
  Future<Map<String, dynamic>> getRequest({required String url}) async {
    try {
      final finalUrl = ApiEndpoints.baseUrl + url;
      final uri = Uri.parse(finalUrl);

      log('🌐 Making GET request to: $finalUrl');

      final response = await http.get(uri);
      return handleResponse(response);
    } catch (e) {
      log('❌ Network error: $e');
      throw Exception('Network error: $e');
    }
  }

  /// Handles HTTP response and converts JSON to Map
  Map<String, dynamic> handleResponse(http.Response response) {
    log('📡 Response status: ${response.statusCode}');
    log('📄 Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        log('✅ Successfully parsed JSON to Map');
        return jsonMap;
      } catch (e) {
        log('❌ JSON parsing error: $e');
        throw Exception('Invalid JSON response: $e');
      }
    } else {
      log('❌ HTTP error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  /// Makes a POST request and returns the response as a Map
  Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers = commonHeaders,
  }) async {
    try {
      final finalUrl = ApiEndpoints.baseUrl + url;
      final uri = Uri.parse(finalUrl);

      log('🌐 Making POST request to: $finalUrl');
      log('📤 Request body: $body');

      final response = await http.post(
        uri,
        headers: commonHeaders,
        body: jsonEncode(body),
      );
      return handleResponse(response);
    } catch (e) {
      log('❌ Network error: $e');
      throw Exception('Network error: $e');
    }
  }
}
