import 'package:dummyjson_api_workshop/screens/all_products_sceen.dart';
import 'package:dummyjson_api_workshop/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApiIntegrationApp());
}

class ApiIntegrationApp extends StatelessWidget {
  const ApiIntegrationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DummyJSON API Workshop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
