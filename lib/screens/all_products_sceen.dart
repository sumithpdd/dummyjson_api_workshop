import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:dummyjson_api_workshop/services/networking.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              log('🔄 Starting API call...');
              final response = await Networking().getRequest(
                url: ApiEndpoints.GET_ALL_PRODUCTS,
              );

              log('✅ API call successful!');
              log('📊 Total products: ${response['total']}');
              log(
                '📦 Products array length: ${(response['products'] as List).length}',
              );

              // TODO: Convert Map to ProductResponse model
              // final productResponse = ProductResponse.fromJson(response);
            } catch (e) {
              log('❌ API call failed: $e');
            }
          },
          child: const Text("Get All Products"),
        ),
      ),
    );
  }
}
