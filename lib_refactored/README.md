# TaskTrial - Refactored Architecture

This is a refactored version of the TaskTrial Flutter application that follows clean architecture principles and best practices.

## 🏗️ Architecture Overview

The refactored codebase follows a **Clean Architecture** pattern with clear separation of concerns:

```
lib_refactored/
├── core/                    # Core functionality and utilities
│   ├── constants/          # App constants, colors, text styles
│   ├── di/                 # Dependency injection setup
│   ├── network/            # Network layer (API client, interceptors)
│   ├── routes/             # App routing configuration
│   ├── storage/            # Local storage management
│   └── utils/              # Utility classes (logger, validators, UI utils)
├── data/                   # Data layer
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/                 # Domain layer (business logic)
│   ├── models/             # Domain models
│   └── services/           # Business logic services
└── presentation/           # Presentation layer
    ├── controllers/        # GetX controllers
    ├── views/              # UI screens and widgets
    └── app.dart           # App configuration
```

## 🎯 Key Improvements

### 1. **Clean Architecture**
- **Separation of Concerns**: Clear boundaries between data, domain, and presentation layers
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class has one reason to change

### 2. **Dependency Injection**
- Centralized dependency management using GetX
- Easy testing and mocking
- Loose coupling between components

### 3. **Repository Pattern**
- Abstract data access layer
- Easy to switch between different data sources
- Consistent error handling

### 4. **Service Layer**
- Business logic separated from UI logic
- Reusable across different controllers
- Better testability

### 5. **Improved Error Handling**
- Centralized error handling with `ApiResponse<T>`
- Consistent error messages
- Better user experience

### 6. **Better State Management**
- Cleaner GetX controllers
- Proper separation of UI and business logic
- Reactive state management

### 7. **Centralized Configuration**
- All constants in one place
- Easy to maintain and update
- Consistent theming

## 🚀 Getting Started

### 1. **Setup Dependencies**

The refactored version uses the same dependencies as the original. Make sure you have:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.2
  dio: ^5.8.0+1
  shared_preferences: ^2.5.3
  flutter_dotenv: ^5.2.1
  # ... other dependencies
```

### 2. **Environment Setup**

Create a `.env` file in your project root:

```env
API_BASE_URL=https://tasktrial-prod.vercel.app/api
API_TIMEOUT=30000
```

### 3. **Initialize the App**

The main.dart file handles all initialization:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Initialize dependency injection
  await DependencyInjection.init();
  
  // Run the app
  runApp(const TaskTrialApp());
}
```

## 📁 Core Components

### 1. **Constants**
- `AppConstants`: API endpoints, timeouts, storage keys
- `AppColors`: Centralized color definitions
- `AppTextStyles`: Typography styles

### 2. **Network Layer**
- `ApiClient`: Centralized HTTP client with error handling
- `ApiInterceptor`: Automatic token management and logging
- `ApiResponse<T>`: Generic response wrapper

### 3. **Storage**
- `LocalStorage`: Type-safe local storage with error handling
- Automatic token management
- User preferences storage

### 4. **Dependency Injection**
- `DependencyInjection`: Centralized DI setup
- Lazy loading for better performance
- Easy testing setup

### 5. **Routing**
- `AppRoutes`: Centralized route management
- Type-safe navigation methods
- Middleware support

## 🔧 Usage Examples

### 1. **Using a Controller**

```dart
class LoginScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
        children: [
          TextField(
            controller: controller.emailController,
            onChanged: (_) => controller.validateEmail(),
          ),
          if (controller.emailError.value != null)
            Text(controller.emailError.value!),
          ElevatedButton(
            onPressed: controller.isLoginFormValid 
              ? controller.login 
              : null,
            child: Text('Login'),
          ),
        ],
      )),
    );
  }
}
```

### 2. **Using Services**

```dart
class AuthService {
  final AuthRepository _authRepository;
  
  Future<bool> login({
    required String email,
    required String password,
    required Function(String) onError,
    required Function(LoginModel) onSuccess,
  }) async {
    // Business logic here
  }
}
```

### 3. **Using Repositories**

```dart
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;
  
  @override
  Future<ApiResponse<LoginModel>> login(String email, String password) async {
    // Data access logic here
  }
}
```

### 4. **Navigation**

```dart
// Simple navigation
AppRoutes.goToLogin();

// Navigation with arguments
AppRoutes.goToResetPasswordWithToken(token);

// Navigation with result
final result = await AppRoutes.goToScreenWithResult<String>('/some-route');
```

### 5. **UI Utilities**

```dart
// Show success message
UiUtils.showSuccessSnackBar(
  title: 'Success',
  message: 'Operation completed successfully',
);

// Show confirmation dialog
final confirmed = await UiUtils.showConfirmationDialog(
  title: 'Confirm',
  message: 'Are you sure?',
);
```

## 🧪 Testing

The refactored architecture makes testing much easier:

### 1. **Unit Testing**

```dart
void main() {
  group('AuthService Tests', () {
    late AuthService authService;
    late MockAuthRepository mockRepository;
    
    setUp(() {
      mockRepository = MockAuthRepository();
      authService = AuthService(authRepository: mockRepository);
    });
    
    test('login should return success for valid credentials', () async {
      // Test implementation
    });
  });
}
```

### 2. **Widget Testing**

```dart
void main() {
  group('LoginScreen Tests', () {
    testWidgets('should show error for invalid email', (tester) async {
      // Test implementation
    });
  });
}
```

## 🔄 Migration Guide

To migrate from the original codebase:

1. **Replace the lib folder** with the refactored version
2. **Update imports** in your existing files
3. **Update controllers** to use the new service layer
4. **Update navigation** to use AppRoutes
5. **Update UI components** to use the new constants and utilities

## 📋 Best Practices

### 1. **Naming Conventions**
- Use descriptive names for classes and methods
- Follow Dart naming conventions
- Use consistent prefixes for related classes

### 2. **Error Handling**
- Always use `ApiResponse<T>` for API calls
- Handle errors gracefully in UI
- Log errors appropriately

### 3. **State Management**
- Keep controllers focused on UI logic
- Use services for business logic
- Use repositories for data access

### 4. **Code Organization**
- Keep related files together
- Use proper folder structure
- Document complex logic

### 5. **Performance**
- Use lazy loading for dependencies
- Implement proper caching strategies
- Optimize network requests

## 🐛 Troubleshooting

### Common Issues

1. **Dependency Injection Errors**
   - Make sure all dependencies are registered in `DependencyInjection`
   - Check for circular dependencies

2. **Navigation Errors**
   - Ensure routes are properly defined in `AppRoutes`
   - Check route names for typos

3. **API Errors**
   - Verify API endpoints in `AppConstants`
   - Check network connectivity
   - Validate request/response models

## 🤝 Contributing

When contributing to the refactored codebase:

1. Follow the established architecture patterns
2. Add proper documentation
3. Write tests for new features
4. Update this README if needed

## 📄 License

This refactored version maintains the same license as the original project.

---

**Note**: This refactored version is designed to be a drop-in replacement for the original codebase while providing better maintainability, testability, and scalability.