import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:dummyjson_api_workshop/services/networking.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Networking().getRequest(url: ApiEndpoints.GET_ALL_PRODUCTS);
          },
          child: Text("Get All Products"),
        ),
      ),
    );
  }
}
