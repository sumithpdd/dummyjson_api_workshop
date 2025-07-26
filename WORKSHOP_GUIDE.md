# DummyJSON API Workshop - Step-by-Step Guide

This guide will walk you through building a complete Flutter app that integrates with the DummyJSON Products API. Follow each step carefully to understand the concepts and build the application.

## 🎯 Workshop Objectives

By the end of this workshop, you'll have built:
- A product listing screen with real API data
- A product detail screen with comprehensive information
- Proper error handling and loading states
- Clean architecture with repository pattern

## 📋 Prerequisites

- Flutter SDK (3.8.1+)
- Basic knowledge of Dart and Flutter
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Git for version control

## 🚀 Workshop Steps

### Step 1: Project Setup ✅ (Already Complete)

**What we have:**
- Flutter project with required packages (`http`, `json_annotation`, `build_runner`, `json_serializable`)
- Basic app structure with Material 3 design
- Navigation extension for BuildContext
- Initial products screen structure

**Verify setup:**
```bash
flutter pub get
flutter run
```

You should see a basic app with "All Products" in the app bar.

---

### Step 2: Create Product Data Models

**Objective:** Create Dart classes to represent the API response structure.

**Tasks:**
1. Create `lib/models/product.dart`
2. Create `lib/models/product_response.dart`
3. Add JSON annotations
4. Generate serialization code

**Expected Outcome:** Models that can parse the DummyJSON API response.

---

### Step 3: Implement API Service

**Objective:** Create a service class to handle HTTP requests to the DummyJSON API.

**Tasks:**
1. Create `lib/services/api_service.dart`
2. Implement methods for fetching products
3. Add error handling
4. Test API connectivity

**Expected Outcome:** A service that can fetch product data from the API.

---

### Step 4: Create Repository Layer

**Objective:** Implement the repository pattern to abstract data sources.

**Tasks:**
1. Create `lib/repositories/product_repository.dart`
2. Implement repository interface
3. Connect repository to API service
4. Add caching logic (optional)

**Expected Outcome:** Clean separation between data layer and business logic.

---

### Step 5: Build Product List Screen

**Objective:** Create a beautiful product listing screen with real data.

**Tasks:**
1. Update `lib/screens/all_products_sceen.dart`
2. Implement state management (setState or Provider)
3. Add loading and error states
4. Create product card widget
5. Implement grid/list layout

**Expected Outcome:** A functional product listing screen with real API data.

---

### Step 6: Create Product Detail Screen

**Objective:** Build a detailed product view with comprehensive information.

**Tasks:**
1. Create `lib/screens/product_detail_screen.dart`
2. Implement navigation from product list
3. Display product images, details, and reviews
4. Add back navigation

**Expected Outcome:** A complete product detail screen with rich information.

---

### Step 7: Add Error Handling & Loading States

**Objective:** Improve user experience with proper loading and error handling.

**Tasks:**
1. Create loading widgets
2. Implement error handling widgets
3. Add retry functionality
4. Handle network connectivity issues

**Expected Outcome:** Robust app that handles various error scenarios gracefully.

---

### Step 8: Polish UI & Add Features

**Objective:** Enhance the user interface and add additional features.

**Tasks:**
1. Add search functionality
2. Implement product filtering
3. Add pull-to-refresh
4. Optimize performance
5. Add animations

**Expected Outcome:** A polished, production-ready app.

---

## 🛠️ Development Tips

### Understanding the Packages

#### HTTP Package
```dart
// Example of how we'll use the http package
import 'package:http/http.dart' as http;

final response = await http.get(Uri.parse('https://dummyjson.com/products'));
if (response.statusCode == 200) {
  // Parse JSON response
  final jsonData = jsonDecode(response.body);
}
```

#### JSON Annotations
```dart
// Example of how we'll use json_annotation
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final double price;
  
  Product({required this.id, required this.title, required this.price});
  
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
```

#### Build Runner Commands
After creating model classes, always run:
```bash
# Generate code once
flutter packages pub run build_runner build

# Or watch for changes and regenerate automatically
flutter packages pub run build_runner watch

# Clean and regenerate (if you encounter issues)
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing API
Test your API calls using:
```bash
# Test the products endpoint
curl https://dummyjson.com/products

# Test with pagination
curl https://dummyjson.com/products?limit=10&skip=0

# Test individual product
curl https://dummyjson.com/products/1
```

### Debugging
- Use `print()` statements for debugging
- Check network tab in browser dev tools
- Use Flutter Inspector for UI debugging

### Best Practices
- Follow Flutter conventions
- Use meaningful variable names
- Add comments for complex logic
- Handle errors gracefully
- Test on different screen sizes

## 📱 Final App Features

Your completed app will have:
- ✅ Product listing with images and basic info
- ✅ Product detail screen with full information
- ✅ Loading states and error handling
- ✅ Clean architecture with repository pattern
- ✅ Responsive design
- ✅ Navigation between screens

## 🔗 Resources

- [DummyJSON API Documentation](https://dummyjson.com/docs)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [JSON Serializable Package](https://pub.dev/packages/json_serializable)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)

## 🆘 Getting Help

If you get stuck:
1. Check the error messages carefully
2. Verify your code matches the examples
3. Ensure all dependencies are installed
4. Restart your Flutter app if needed
5. Check the Flutter documentation

## 🎉 Next Steps

After completing this workshop:
- Try adding more features (search, filters, pagination)
- Implement state management with Provider or Bloc
- Add unit tests for your models and services
- Deploy your app to the web or mobile stores

---

**Ready to start? Begin with Step 2: Create Product Data Models!** 