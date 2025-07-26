# DummyJSON API Workshop

A Flutter workshop project that demonstrates API integration with the [DummyJSON Products API](https://dummyjson.com/products). This project showcases how to build a product listing and detail screens with real API data.

## 🎯 Project Overview

This workshop will guide you through building:
- **Product List Screen**: Display products in a grid/list format with thumbnails, titles, prices, and ratings
- **Product Detail Screen**: Show comprehensive product information including images, reviews, specifications, and metadata

## 📦 Packages Used

### Core Dependencies

#### **`http`** (^1.1.0)
- **Purpose**: HTTP client for making network requests
- **Why we need it**: To fetch product data from the DummyJSON API
- **What it provides**: 
  - Simple HTTP GET, POST, PUT, DELETE requests
  - Response handling with status codes
  - JSON parsing capabilities
  - Error handling for network issues
- **Usage in workshop**: Making API calls to `https://dummyjson.com/products`

#### **`json_annotation`** (^4.8.1)
- **Purpose**: Provides annotations for JSON serialization/deserialization
- **Why we need it**: To automatically convert JSON data from API to Dart objects
- **What it provides**:
  - `@JsonSerializable()` annotation for classes
  - `@JsonKey()` for custom field mapping
  - Type-safe JSON parsing
  - Reduces boilerplate code significantly
- **Usage in workshop**: Annotating our Product model classes

### Development Dependencies

#### **`build_runner`** (^2.4.7)
- **Purpose**: Code generation tool that runs build scripts
- **Why we need it**: To generate the actual JSON parsing code from annotations
- **What it provides**:
  - Watches for file changes and regenerates code
  - Runs code generation in the background
  - Handles dependency tracking
  - Supports multiple build systems
- **Usage in workshop**: Running `flutter packages pub run build_runner build`

#### **`json_serializable`** (^6.7.1)
- **Purpose**: Automatically generates JSON parsing code from annotated classes
- **Why we need it**: Eliminates manual JSON parsing and reduces errors
- **What it provides**:
  - Generates `fromJson()` and `toJson()` methods
  - Handles complex nested objects
  - Supports custom converters
  - Type-safe serialization
- **Usage in workshop**: Creating Product models that can parse API responses

### Package Workflow

1. **`json_annotation`** → Define the structure with annotations
2. **`json_serializable`** → Generate parsing code (with build_runner)
3. **`http`** → Fetch JSON data from API
4. **Generated code** → Convert JSON to Dart objects automatically

This combination eliminates manual JSON parsing and provides type-safe, maintainable code.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.8.1 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd dummyjson_api_workshop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Code Generation

After creating model classes with JSON annotations, run the following command to generate the serialization code:

```bash
flutter packages pub run build_runner build
```

Or for continuous generation during development:

```bash
flutter packages pub run build_runner watch
```

## 📱 Features

- **API Integration**: Real-time data from DummyJSON Products API
- **Product Browsing**: Browse through a catalog of products
- **Product Details**: View detailed product information
- **Responsive Design**: Works on various screen sizes
- **Modern UI**: Clean and intuitive user interface

## 🏗️ Project Structure

```
lib/
├── main.dart                           # App entry point
├── models/                             # Data models for API responses
│   └── .gitkeep                       # Placeholder for model files
├── services/                           # API service classes
│   └── .gitkeep                       # Placeholder for service files
├── repositories/                       # Data repository layer
│   └── .gitkeep                       # Placeholder for repository files
├── screens/                            # UI screens
│   └── all_products_sceen.dart        # Products listing screen
├── widgets/                            # Reusable UI components
│   └── .gitkeep                       # Placeholder for widget files
└── extensions/                         # Dart extensions
    └── build_context_extension.dart   # BuildContext utility methods
```

### Current Implementation Status

✅ **Completed:**
- Project setup with required packages
- Basic app structure with Material 3 design
- Navigation extension for BuildContext
- Initial products screen structure

🔄 **In Progress:**
- Product data models
- API service implementation
- Product listing UI

📋 **Planned:**
- Product detail screen
- Repository pattern implementation
- Error handling and loading states
- Responsive UI components

## 🔗 API Reference

This project uses the [DummyJSON Products API](https://dummyjson.com/products) which provides:
- Product listings with pagination
- Individual product details
- Rich product data including images, reviews, and metadata

## 📚 Learning Objectives

By the end of this workshop, you'll understand:
- How to integrate external APIs in Flutter
- JSON serialization and deserialization
- State management for API data
- Building responsive UI layouts
- Navigation between screens
- Error handling for network requests
- Repository pattern implementation
- Extension methods in Dart

## 📖 Workshop Guide

For a complete step-by-step tutorial, see **[WORKSHOP_GUIDE.md](WORKSHOP_GUIDE.md)** which includes:
- Detailed instructions for each step
- Code examples and explanations
- Development tips and best practices
- Troubleshooting guide

## 🤝 Contributing

This is a workshop project. Feel free to experiment and modify the code to learn different approaches.

## 📄 License

This project is for educational purposes.
