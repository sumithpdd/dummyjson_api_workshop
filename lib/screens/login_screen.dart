import 'dart:developer';

import 'package:dummyjson_api_workshop/screens/all_products_sceen.dart';
import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:dummyjson_api_workshop/services/networking.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await Networking().postRequest(
              url: ApiEndpoints.POST_LOGIN,
              body: {'username': 'emilys', 'password': 'emilyspass'},
            );
            log('Response: $response');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllProductsScreen()),
            );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
