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
}
```

**Key Improvements:**
- ✅ **Enhanced Logging**: Detailed logs with emojis for better debugging
- ✅ **Better Error Handling**: Specific error messages for different failure types
- ✅ **Type Safety**: Returns `Map<String, dynamic>` instead of String
- ✅ **JSON Validation**: Proper JSON parsing with error handling
- ✅ **HTTP Status Details**: Includes status codes and reason phrases in errors

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
}
```

**Benefits:**
- ✅ Centralized HTTP request handling
- ✅ Proper error handling and status code checking
- ✅ Reusable across the entire application
- ✅ Clean separation of concerns

---

### Step 3: Create Product Data Models ✅ (Already Complete)

**Objective:** Create Dart classes to represent the API response structure.

**What we have:**
- `lib/models/products.dart` - Product model with JSON annotations
- Using `json_annotation` package for code generation
- Commented out manual `fromJson` implementation to showcase automation

**Current Implementation:**
```dart
import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Products {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  // Manual implementation (commented out to showcase automation)
  // factory Products.fromJson(Map<String, dynamic> json) {
  //   return Products(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     price: json['price'],
  //     discountPercentage: json['discountPercentage'],
  //     rating: json['rating'],
  //     stock: json['stock'],
  //     brand: json['brand'],
  //     category: json['category'],
  //     thumbnail: json['thumbnail'],
  //     images: json['images'],
  //   );
  // }

  // Generated implementation (will be created by build_runner)
  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
```

**Key Concepts Implemented:**

1. **JSON Annotations**: `@JsonSerializable()` tells the code generator to create serialization methods
2. **Part Files**: `part 'products.g.dart'` links to the generated code file
3. **Nullable Fields**: Using `?` for optional fields that might be null in the API response
4. **Type Safety**: Proper Dart types for each field (int, String, num, List<String>)
5. **Code Generation**: Automated creation of `fromJson` and `toJson` methods

**Benefits of Using json_annotation:**

- ✅ **Reduces Boilerplate**: No need to write manual JSON parsing code
- ✅ **Type Safety**: Compile-time checking for field types
- ✅ **Maintainability**: Easy to add/remove fields without breaking serialization
- ✅ **Performance**: Generated code is optimized and efficient
- ✅ **Error Prevention**: Catches typos and type mismatches at compile time
- ✅ **Consistency**: Standardized approach across all models

**Next Step:** Generate the serialization code using build_runner ✅ (Complete)

**Generated Code:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**What was created:**
- `lib/models/products.g.dart` - Automatically generated serialization code

**Generated Implementation:**
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'products.dart';

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: json['price'] as num?,
  discountPercentage: json['discountPercentage'] as num?,
  rating: json['rating'] as num?,
  stock: (json['stock'] as num?)?.toInt(),
  brand: json['brand'] as String?,
  category: json['category'] as String?,
  thumbnail: json['thumbnail'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'discountPercentage': instance.discountPercentage,
  'rating': instance.rating,
  'stock': instance.stock,
  'brand': instance.brand,
  'category': instance.category,
  'thumbnail': instance.thumbnail,
  'images': instance.images,
};
```

**Key Features of Generated Code:**

1. **Type Conversion**: Automatically handles `num` to `int` conversion for `id` and `stock`
2. **Null Safety**: Properly handles nullable fields with `?` operators
3. **List Processing**: Converts `List<dynamic>` to `List<String>` for images
4. **Bidirectional**: Creates both `fromJson` (deserialization) and `toJson` (serialization)
5. **Optimized**: Generated code is efficient and handles edge cases

**Comparison: Manual vs Generated**

**Manual Implementation (30+ lines):**
```dart
factory Products.fromJson(Map<String, dynamic> json) {
  return Products(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    // ... 8 more lines
    images: json['images'],
  );
}
```

**Generated Implementation (15 lines):**
```dart
Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  // ... handles all type conversions automatically
);
```

**Benefits Demonstrated:**
- ✅ **Less Code**: Generated version is more concise
- ✅ **Type Safety**: Proper type casting and null handling
- ✅ **Maintainability**: Add/remove fields and regenerate
- ✅ **Error Prevention**: Compile-time validation
- ✅ **Performance**: Optimized generated code

**Usage Example:**
```dart
// Parse JSON string to Products object
final jsonString = '{"id": 1, "title": "Product", ...}';
final jsonMap = jsonDecode(jsonString);
final product = Products.fromJson(jsonMap);

// Convert Products object back to JSON
final jsonMap = product.toJson();
final jsonString = jsonEncode(jsonMap);
```

**Complete API Response Model:**

We also created `lib/models/product_response.dart` to handle the complete API response structure:

```dart
@JsonSerializable()
class ProductResponse {
  final List<Products>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
```

**Generated ProductResponse Code:**
```dart
ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );
```

**Key Features:**
- ✅ **Nested Parsing**: Automatically parses the products array into `List<Products>`
- ✅ **Pagination Support**: Handles `total`, `skip`, and `limit` fields
- ✅ **Type Safety**: Proper type conversion for all fields
- ✅ **Null Safety**: Handles optional fields gracefully

**Complete Usage Example:**
```dart
// Parse complete API response
final apiResponse = '{"products": [...], "total": 100, "skip": 0, "limit": 30}';
final jsonMap = jsonDecode(apiResponse);
final productResponse = ProductResponse.fromJson(jsonMap);

// Access individual products
final products = productResponse.products ?? [];
final totalProducts = productResponse.total ?? 0;

// Access first product details
if (products.isNotEmpty) {
  final firstProduct = products.first;
  print('Product: ${firstProduct.title}');
  print('Price: \$${firstProduct.price}');
}
```

---

### Step 4: Implement Repository Layer ✅ (Already Complete)

**Objective:** Create a repository layer to abstract data sources and handle API calls.

**What we have:**
- `lib/repositories/product_repository.dart` - Repository pattern implementation

**Current Implementation:**
```dart
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
```

**Key Features:**
- ✅ **Repository Pattern**: Clean separation between data layer and business logic
- ✅ **Type Safety**: Returns strongly-typed `List<Products>` and `Products` objects
- ✅ **Error Handling**: Propagates errors from networking layer
- ✅ **Reusable**: Can be used across different screens and widgets
- ✅ **Testable**: Easy to mock for unit testing

**Benefits:**
- **Abstraction**: Hides API implementation details from UI layer
- **Maintainability**: Single place to modify data fetching logic
- **Scalability**: Easy to add caching, offline support, or multiple data sources
- **Testing**: Can easily mock repository for testing UI components

---

### Step 5: Create Reusable Widgets ✅ (Already Complete)

**Objective:** Create reusable UI components for better code organization.

**What we have:**
- `lib/widgets/product_row.dart` - Reusable product list item widget

**Current Implementation:**
```dart
class ProductsRow extends StatelessWidget {
  const ProductsRow({super.key, required this.currentProduct});
  final Products currentProduct;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        currentProduct.images!.first,
        width: 75,
        fit: BoxFit.fitWidth,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              productId: currentProduct.id!.toString(),
            ),
          ),
        );
      },
      title: Text(currentProduct.title!),
      subtitle: Text(currentProduct.description!),
      trailing: Text(currentProduct.price.toString()),
    );
  }
}
```

**Key Features:**
- ✅ **Reusable Component**: Can be used in multiple screens
- ✅ **Navigation**: Handles navigation to product detail screen
- ✅ **Image Display**: Shows product thumbnail
- ✅ **Product Information**: Displays title, description, and price
- ✅ **Tap Handling**: Navigates to detail screen on tap

**Benefits:**
- **Code Reusability**: Single widget for product display across the app
- **Maintainability**: Changes to product display logic in one place
- **Consistency**: Ensures uniform product display throughout the app
- **Separation of Concerns**: UI logic separated from business logic

---

### Step 6: Build Product List Screen ✅ (Already Complete)

**Objective:** Create a beautiful product listing screen with real data.

**Current Progress:**
- ✅ Added test button to call networking layer
- ✅ Integrated API endpoints and networking
- ✅ Added logging to see API response
- ✅ Implemented state management with StatefulWidget
- ✅ Integrated repository pattern
- ✅ Created reusable product row widget
- ✅ Added navigation to product detail screen

**Current Implementation:**
```dart
class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Products> _products = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getAllProducts();
    });
  }

  Future<void> getAllProducts() async {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    _products = response['products']
        .map<Products>((json) => Products.fromJson(json))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Center(
        child: _products.isNotEmpty
            ? ListView.separated(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final currentProduct = _products[index];
                  return ProductsRow(currentProduct: currentProduct);
                },
                separatorBuilder: (context, index) => const Divider(),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
```

**Key Features Implemented:**
- ✅ **State Management**: Using StatefulWidget with setState
- ✅ **Auto-loading**: Products load automatically on screen initialization
- ✅ **Loading State**: Shows CircularProgressIndicator while loading
- ✅ **Product Display**: Uses reusable ProductsRow widget
- ✅ **Navigation**: Tapping products navigates to detail screen
- ✅ **Error Handling**: Basic error handling in place
- ✅ **Clean UI**: ListView with separators for better visual separation

**Testing the Implementation:**

1. **Run the app:**
   ```bash
   flutter run
   ```

2. **What you should see:**
   - Loading indicator initially
   - List of products with images, titles, descriptions, and prices
   - Tapping any product navigates to its detail screen

3. **Console output:**
   ```
   🌐 Making GET request to: https://dummyjson.com/products
   📡 Response status: 200
   ✅ Successfully parsed JSON to Map
   ```

**Current Features:**
- ✅ **Real API Data**: Products loaded from DummyJSON API
- ✅ **Responsive UI**: ListView adapts to different screen sizes
- ✅ **Navigation**: Seamless navigation between list and detail screens
- ✅ **Reusable Components**: ProductsRow widget for consistent display

---

### Step 7: Create Product Detail Screen ✅ (Already Complete)

**Objective:** Build a detailed product view with comprehensive information.

**What we have:**
- `lib/screens/product_detail_screen.dart` - Complete product detail screen with API integration

**Current Implementation:**
```dart
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductRepository _repository = ProductRepository();
  Products? _product;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final product = await _repository.getProductById(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _product != null
                  ? ProductsDetailsWidget(product: _product!)
                  : const Center(child: Text('Product not found')),
    );
  }
}
```

**Key Features Implemented:**
- ✅ **Dynamic Loading**: Loads product data based on product ID
- ✅ **Repository Integration**: Uses ProductRepository for data fetching
- ✅ **Loading States**: Shows loading indicator while fetching data
- ✅ **Error Handling**: Displays error messages if API call fails
- ✅ **State Management**: Proper state management with setState
- ✅ **Navigation**: Seamless navigation from product list

**Product Details Widget:**
```dart
class ProductsDetailsWidget extends StatelessWidget {
  const ProductsDetailsWidget({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(product.title!),
          Image.network(product.images!.first, width: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description!),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add To Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
```

**Features Displayed:**
- ✅ **Product Title**: Clear product name display
- ✅ **Product Image**: High-quality product image
- ✅ **Product Description**: Detailed product information
- ✅ **Add to Cart Button**: Ready for e-commerce functionality
- ✅ **Responsive Layout**: Adapts to different screen sizes

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
  // response is now a Map<String, dynamic> from the API
  print('Total products: ${response['total']}');
  print('Products: ${response['products']}');
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
    print('Total products: ${response['total']}');
    print('Products array: ${response['products']}');
    // TODO: Convert Map to ProductResponse model
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
    // Convert Map to ProductResponse model
    final productResponse = ProductResponse.fromJson(response);
    setState(() {
      this.products = productResponse.products ?? [];
      this.totalProducts = productResponse.total ?? 0;
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

**Ready to start? Begin with Step 4: Implement API Service!**

---

## 🎯 Workshop Completion Summary

Congratulations! You've successfully built a complete Flutter app with:

### ✅ **What We Accomplished:**

1. **Project Setup**: Flutter project with all necessary packages
2. **API Integration**: HTTP networking layer with error handling
3. **Data Models**: JSON serialization with code generation
4. **Repository Pattern**: Clean data layer abstraction
5. **Reusable Widgets**: Product row component
6. **Product List Screen**: Real-time data from API
7. **Product Detail Screen**: Dynamic content loading
8. **Navigation**: Seamless screen transitions

### 🏗️ **Architecture Implemented:**

```
lib/
├── models/           # Data models with JSON serialization
├── services/         # API endpoints and networking
├── repositories/     # Data layer abstraction
├── screens/          # UI screens with state management
├── widgets/          # Reusable UI components
└── extensions/       # Utility extensions
```

### 🚀 **Key Features:**

- **Real API Integration**: DummyJSON Products API
- **Type Safety**: Strongly-typed models throughout
- **Error Handling**: Graceful error management
- **Loading States**: User-friendly loading indicators
- **Responsive UI**: Adapts to different screen sizes
- **Clean Architecture**: Separation of concerns

---

## 📚 Assignment Ideas to Improve the Workshop

### **Beginner Level Assignments:**

#### 1. **Enhanced Error Handling** ⭐
- **Task**: Implement better error handling with retry functionality
- **Skills**: Error handling, user experience
- **Implementation**: Add retry buttons, error messages, offline detection

#### 2. **Search Functionality** ⭐
- **Task**: Add search bar to filter products by title or category
- **Skills**: State management, filtering, UI design
- **Implementation**: SearchController, filtered list display

#### 3. **Pull-to-Refresh** ⭐
- **Task**: Implement pull-to-refresh functionality
- **Skills**: RefreshIndicator, async operations
- **Implementation**: RefreshIndicator widget, reload data

#### 4. **Product Categories** ⭐
- **Task**: Add category filtering and display
- **Skills**: Data grouping, UI organization
- **Implementation**: Category tabs, filtered product lists

### **Intermediate Level Assignments:**

#### 5. **State Management with Provider** ⭐⭐
- **Task**: Replace setState with Provider for state management
- **Skills**: Provider package, state management patterns
- **Implementation**: ProductProvider, ChangeNotifier

#### 6. **Image Caching** ⭐⭐
- **Task**: Implement image caching for better performance
- **Skills**: Caching strategies, performance optimization
- **Implementation**: cached_network_image package

#### 7. **Pagination** ⭐⭐
- **Task**: Implement infinite scroll pagination
- **Skills**: ScrollController, pagination logic
- **Implementation**: Load more products on scroll

#### 8. **Local Storage** ⭐⭐
- **Task**: Add offline support with local storage
- **Skills**: SharedPreferences, local database
- **Implementation**: Cache products locally, offline mode

### **Advanced Level Assignments:**

#### 9. **Authentication System** ⭐⭐⭐
- **Task**: Implement user login/registration
- **Skills**: Authentication, secure storage, API integration
- **Implementation**: Login screen, token management, protected routes

#### 10. **Shopping Cart** ⭐⭐⭐
- **Task**: Build a complete shopping cart system
- **Skills**: State management, data persistence, e-commerce logic
- **Implementation**: Cart model, cart screen, checkout flow

#### 11. **Product Reviews & Ratings** ⭐⭐⭐
- **Task**: Add review system with ratings
- **Skills**: Complex UI, user input, data validation
- **Implementation**: Review model, rating widget, review submission

#### 12. **Advanced UI/UX** ⭐⭐⭐
- **Task**: Implement advanced UI features
- **Skills**: Custom animations, advanced layouts, theming
- **Implementation**: Hero animations, custom themes, responsive design

### **Expert Level Assignments:**

#### 13. **Testing Suite** ⭐⭐⭐⭐
- **Task**: Add comprehensive testing
- **Skills**: Unit testing, widget testing, integration testing
- **Implementation**: Test models, test widgets, test API calls

#### 14. **Performance Optimization** ⭐⭐⭐⭐
- **Task**: Optimize app performance
- **Skills**: Performance profiling, optimization techniques
- **Implementation**: Lazy loading, memory management, performance monitoring

#### 15. **Multi-language Support** ⭐⭐⭐⭐
- **Task**: Add internationalization
- **Skills**: i18n, localization, cultural considerations
- **Implementation**: Localization files, language switching

#### 16. **Advanced State Management** ⭐⭐⭐⭐
- **Task**: Implement Bloc/Cubit pattern
- **Skills**: Advanced state management, reactive programming
- **Implementation**: Bloc pattern, event-driven architecture

### **Bonus Challenges:**

#### 17. **Real-time Features** 🚀
- **Task**: Add real-time updates (WebSocket)
- **Skills**: Real-time communication, WebSocket
- **Implementation**: Live product updates, notifications

#### 18. **Push Notifications** 🚀
- **Task**: Implement push notifications
- **Skills**: Firebase, notification handling
- **Implementation**: FCM integration, notification management

#### 19. **Analytics & Monitoring** 🚀
- **Task**: Add analytics and crash reporting
- **Skills**: Analytics, monitoring, data analysis
- **Implementation**: Firebase Analytics, crash reporting

#### 20. **Deployment** 🚀
- **Task**: Deploy to app stores
- **Skills**: App store deployment, CI/CD
- **Implementation**: Build configuration, store listings

---

## 🎓 Learning Path Recommendations

### **For Beginners:**
1. Start with assignments 1-4 to strengthen fundamentals
2. Focus on UI/UX improvements and basic functionality
3. Practice with state management and error handling

### **For Intermediate Developers:**
1. Complete assignments 5-8 to learn advanced patterns
2. Implement Provider and local storage
3. Add performance optimizations

### **For Advanced Developers:**
1. Tackle assignments 9-12 for complex features
2. Build authentication and e-commerce features
3. Implement comprehensive testing

### **For Experts:**
1. Complete assignments 13-16 for production-ready features
2. Focus on testing, performance, and scalability
3. Implement advanced architectural patterns

---

## 🏆 Success Metrics

Track your progress with these metrics:

- **Code Quality**: Clean, maintainable, well-documented code
- **User Experience**: Smooth, responsive, intuitive interface
- **Performance**: Fast loading, efficient memory usage
- **Error Handling**: Graceful error management
- **Testing**: Comprehensive test coverage
- **Architecture**: Clean, scalable, maintainable structure

---

## 🎉 Congratulations!

You've completed the DummyJSON API Workshop! You now have:

- ✅ **Real-world Flutter development experience**
- ✅ **API integration skills**
- ✅ **Clean architecture understanding**
- ✅ **State management knowledge**
- ✅ **UI/UX development skills**

**Keep building, keep learning, and happy coding!** 🚀 