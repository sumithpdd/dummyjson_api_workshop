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
- API endpoints configuration

**Files Created:**
- `lib/services/api_endpoints.dart` - Centralized API endpoint management
- `lib/services/networking.dart` - HTTP networking layer with error handling

**Purpose of API Endpoints:**
- **Centralized Configuration**: All API URLs in one place for easy maintenance
- **Type Safety**: Constants prevent typos in API URLs
- **Scalability**: Easy to add new endpoints as the app grows
- **Environment Management**: Can easily switch between development/production URLs

**Code Structure:**
```dart
class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';
  static const String GET_ALL_PRODUCTS = '/products';
  static const String POST_LOGIN = '/auth/login';
}
```

**Benefits:**
- ✅ No hardcoded URLs scattered throughout the codebase
- ✅ Easy to update API endpoints in one location
- ✅ Prevents runtime errors from mistyped URLs
- ✅ Follows clean architecture principles

**Purpose of Networking Layer:**
- **Abstraction**: Provides a clean interface for HTTP requests
- **Error Handling**: Centralized error management for network operations
- **Reusability**: Can be used across different parts of the app
- **Maintainability**: Single place to modify network behavior

**Code Structure:**
```dart
class Networking {
  Future<String> getRequest({required String url}) async {
    final finalUrl = ApiEndpoints.baseUrl + url;
    final uri = Uri.parse(finalUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
```

**Verify setup:**
```bash
flutter pub get
flutter run
```

You should see a basic app with "All Products" in the app bar.

---

### Step 2: Create Networking Layer ✅ (Already Complete)

**Objective:** Create a reusable networking layer for HTTP requests.

**What we have:**
- `lib/services/networking.dart` - HTTP networking layer with error handling

**Key Concepts Implemented:**
- **Future, Async, Await**: For asynchronous network operations
- **HTTP Package**: Using `import 'package:http/http.dart' as http`
- **URI Parsing**: `Uri.parse()` for URL validation
- **Status Code Handling**: Checking response status codes
- **Error Handling**: Throwing exceptions for failed requests

**Code Structure:**
```dart
class Networking {
  Future<String> getRequest({required String url}) async {
    final finalUrl = ApiEndpoints.baseUrl + url;
    final uri = Uri.parse(finalUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
```

**Benefits:**
- ✅ Centralized HTTP request handling
- ✅ Proper error handling and status code checking
- ✅ Reusable across the entire application
- ✅ Clean separation of concerns

---

### Step 3: Create Product Data Models

**Objective:** Create Dart classes to represent the API response structure.

**Tasks:**
1. Create `lib/models/product.dart`
2. Create `lib/models/product_response.dart`
3. Add JSON annotations
4. Generate serialization code

**Expected Outcome:** Models that can parse the DummyJSON API response.

---

### Step 4: Implement API Service

**Objective:** Create a service class to handle HTTP requests to the DummyJSON API.

**Tasks:**
1. Create `lib/services/api_service.dart`
2. Implement methods for fetching products
3. Add error handling
4. Test API connectivity

**Expected Outcome:** A service that can fetch product data from the API.

---

### Step 5: Create Repository Layer

**Objective:** Implement the repository pattern to abstract data sources.

**Tasks:**
1. Create `lib/repositories/product_repository.dart`
2. Implement repository interface
3. Connect repository to API service
4. Add caching logic (optional)

**Expected Outcome:** Clean separation between data layer and business logic.

---

### Step 6: Build Product List Screen

**Objective:** Create a beautiful product listing screen with real data.

**Current Progress:**
- ✅ Added test button to call networking layer
- ✅ Integrated API endpoints and networking
- ✅ Added logging to see API response

**Current Implementation:**
```dart
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
```

**Next Tasks:**
1. Add async/await to handle the Future properly
2. Implement state management (setState or Provider)
3. Add loading and error states
4. Create product card widget
5. Implement grid/list layout

**Expected Outcome:** A functional product listing screen with real API data.

**Testing the Current Implementation:**

1. **Run the app:**
   ```bash
   flutter run
   ```

2. **Test the API call:**
   - Tap the "Get All Products" button
   - Check the console/debug output for the API response
   - You should see a large JSON string with product data

3. **What you should see in the console:**
   ```
   {"products":[{"id":1,"title":"Essence Mascara Lash Princess",...}]}
   ```

4. **Current Issues to Fix:**
   - The button doesn't show loading state
   - No error handling if the API fails
   - The response is just logged, not displayed in the UI
   - Need to convert the JSON string to Dart objects

**Next Steps:**
- Add proper async/await handling
- Convert JSON response to Product objects
- Display the data in a beautiful UI

---

### Step 7: Create Product Detail Screen

**Objective:** Build a detailed product view with comprehensive information.

**Tasks:**
1. Create `lib/screens/product_detail_screen.dart`
2. Implement navigation from product list
3. Display product images, details, and reviews
4. Add back navigation

**Expected Outcome:** A complete product detail screen with rich information.

---

### Step 8: Add Error Handling & Loading States

**Objective:** Improve user experience with proper loading and error handling.

**Tasks:**
1. Create loading widgets
2. Implement error handling widgets
3. Add retry functionality
4. Handle network connectivity issues

**Expected Outcome:** Robust app that handles various error scenarios gracefully.

---

### Step 9: Polish UI & Add Features

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

#### Key Concepts Explained

**1. Future, Async, and Await:**

## 🕐 What is Asynchronous Programming?

Think of it like ordering food at a restaurant:
- **Synchronous**: You stand at the counter and wait until your food is ready (blocking everything else)
- **Asynchronous**: You order, get a number, sit down, and do other things while waiting (non-blocking)

## 📦 Future - The "Promise" of Data

A `Future` is like a "promise" that says "I'll give you this data later, but not right now."

```dart
// Future represents a value that will be available later
Future<String> getRequest({required String url}) async {
  // async keyword allows the use of await
  final response = await http.get(uri); // await pauses execution until response is ready
  return response.body; // Returns a Future<String>
}
```

**Real-world analogy**: A Future is like ordering a pizza. You get a receipt (Future) that promises you'll get a pizza (data) when it's ready.

## ⚡ Async - "I'm Going to Take Some Time"

The `async` keyword tells Dart: "This function will take time to complete, so don't wait for it to finish before moving on."

```dart
// Without async - this would block everything
String getData() {
  // This would freeze the app while waiting
  return http.get(url); // ❌ This doesn't work!
}

// With async - this allows other things to happen
Future<String> getData() async {
  // This allows the app to stay responsive
  return await http.get(url); // ✅ This works!
}
```

**Real-world analogy**: `async` is like saying "I'm going to the store" - you're telling people you'll be gone for a while.

## ⏸️ Await - "Wait for This to Finish"

The `await` keyword says: "Pause here until this operation completes, then continue."

```dart
Future<String> getRequest({required String url}) async {
  print("Starting request..."); // This runs immediately
  
  final response = await http.get(uri); // ⏸️ Pause here until response arrives
  
  print("Got response!"); // This runs after the response arrives
  return response.body;
}
```

**Real-world analogy**: `await` is like waiting for your coffee to brew. You can't drink it until it's done, so you wait.

## 🔄 Complete Example with Explanation

```dart
Future<List<Product>> fetchProducts() async {
  print("🔄 Starting to fetch products...");
  
  try {
    // ⏸️ Wait for the network request to complete
    final response = await networking.getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    
    print("✅ Got response from API");
    
    // ⏸️ Wait for JSON parsing to complete
    final jsonData = await jsonDecode(response);
    
    print("✅ Parsed JSON data");
    
    // Convert to Product objects
    final products = (jsonData['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
    
    print("✅ Converted to ${products.length} products");
    return products;
    
  } catch (e) {
    print("❌ Error: $e");
    throw Exception('Failed to fetch products');
  }
}
```

## 🎯 Why This Matters in Flutter

**Without async/await (blocking):**
```dart
// ❌ This would freeze the entire app
String data = http.get(url); // App freezes here!
```

**With async/await (non-blocking):**
```dart
// ✅ This keeps the app responsive
Future<String> data = http.get(url); // App stays responsive!
```

## 🔗 Helpful Resources

- **[Dart Futures Tutorial](https://dart.dev/codelabs/async-await)**: Official Dart async/await guide
- **[Flutter Async Programming](https://docs.flutter.dev/cookbook/networking/background-parsing)**: Flutter's guide to async operations
- **[Future vs Stream](https://dart.dev/tutorials/language/streams)**: Understanding different async patterns
- **[Error Handling with Futures](https://dart.dev/guides/language/language-tour#handling-futures)**: How to handle errors in async code

## 🧪 Practice Examples

**Simple Future:**
```dart
Future<String> getGreeting() async {
  await Future.delayed(Duration(seconds: 2)); // Simulate delay
  return "Hello, World!";
}

// Usage
void main() async {
  print("Starting...");
  final greeting = await getGreeting();
  print(greeting); // Prints after 2 seconds
}
```

**Multiple Futures:**
```dart
Future<void> loadData() async {
  print("Loading user data...");
  final user = await fetchUser();
  
  print("Loading user posts...");
  final posts = await fetchPosts(user.id);
  
  print("Loading user photos...");
  final photos = await fetchPhotos(user.id);
  
  print("All data loaded!");
}
```

**Parallel Futures (faster):**
```dart
Future<void> loadDataParallel() async {
  print("Loading all data in parallel...");
  
  // All requests start at the same time
  final userFuture = fetchUser();
  final postsFuture = fetchPosts(userId);
  final photosFuture = fetchPhotos(userId);
  
  // Wait for all to complete
  final results = await Future.wait([
    userFuture,
    postsFuture,
    photosFuture,
  ]);
  
  print("All data loaded in parallel!");
}
```

**2. HTTP Package Import:**
```dart
import 'package:http/http.dart' as http;
```

**Why `as http`:**
- **Namespace**: Prevents conflicts with other HTTP-related classes
- **Clarity**: Makes it clear which HTTP methods we're using
- **Convention**: Standard practice in Dart/Flutter

**3. URI Parsing:**
```dart
final uri = Uri.parse(finalUrl);
```

**Why parse URI:**
- **Validation**: Ensures the URL is properly formatted
- **Security**: Prevents malformed URLs that could cause issues
- **HTTP Package Requirement**: The http package expects Uri objects, not strings

**4. Response Status Code Handling:**
```dart
if (response.statusCode == 200) {
  return response.body;
} else {
  throw Exception('Failed to load data');
}
```

**Why handle status codes:**
- **200**: Success - data received correctly
- **404**: Not Found - resource doesn't exist
- **500**: Server Error - something went wrong on the server
- **Error Handling**: Prevents app crashes and provides user feedback

#### API Endpoints Management
```dart
// Example of how we'll use the API endpoints
import 'package:dummyjson_api_workshop/services/api_endpoints.dart';

// Instead of hardcoding URLs, we use constants
final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.GET_ALL_PRODUCTS}';
// Results in: https://dummyjson.com/products
```

#### Networking Layer Usage
```dart
// Example of how we'll use the networking layer
import 'package:dummyjson_api_workshop/services/networking.dart';
import 'package:dummyjson_api_workshop/services/api_endpoints.dart';

final networking = Networking();

try {
  final response = await networking.getRequest(
    url: ApiEndpoints.GET_ALL_PRODUCTS,
  );
  // response contains the JSON string from the API
  print(response);
} catch (e) {
  // Handle network errors
  print('Error: $e');
}
```

#### Current Implementation vs Best Practice

**Current (Basic):**
```dart
onPressed: () {
  Networking().getRequest(url: ApiEndpoints.GET_ALL_PRODUCTS);
},
```

**Improved (With async/await):**
```dart
onPressed: () async {
  try {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    print('API Response: $response');
    // TODO: Parse JSON and update UI
  } catch (e) {
    print('Error: $e');
    // TODO: Show error message to user
  }
},
```

**Best Practice (With State Management):**
```dart
onPressed: () async {
  setState(() {
    isLoading = true;
  });
  
  try {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    final products = parseProductsFromJson(response);
    setState(() {
      this.products = products;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      error = e.toString();
      isLoading = false;
    });
  }
},
```

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

**Ready to start? Begin with Step 3: Create Product Data Models!** 