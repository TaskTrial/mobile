import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';
import '../../presentation/controllers/auth_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    // Initialize core services
    await _initCoreServices();
    
    // Initialize repositories
    _initRepositories();
    
    // Initialize services
    _initServices();
    
    // Initialize controllers
    _initControllers();
  }
  
  static Future<void> _initCoreServices() async {
    // Initialize local storage
    await LocalStorage.init();
    
    // API Client is already a singleton, no need to register
    Get.lazyPut<ApiClient>(() => ApiClient.instance, fenix: true);
    
    // Local Storage
    Get.lazyPut<LocalStorage>(() => LocalStorage.instance, fenix: true);
  }
  
  static void _initRepositories() {
    // Auth Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
        localStorage: Get.find<LocalStorage>(),
      ),
      fenix: true,
    );
    
    // Add other repositories here as needed
    // Get.lazyPut<UserRepository>(() => UserRepositoryImpl(), fenix: true);
    // Get.lazyPut<ProjectRepository>(() => ProjectRepositoryImpl(), fenix: true);
    // Get.lazyPut<TaskRepository>(() => TaskRepositoryImpl(), fenix: true);
    // Get.lazyPut<TeamRepository>(() => TeamRepositoryImpl(), fenix: true);
    // Get.lazyPut<OrganizationRepository>(() => OrganizationRepositoryImpl(), fenix: true);
  }
  
  static void _initServices() {
    // Auth Service
    Get.lazyPut<AuthService>(
      () => AuthService(
        authRepository: Get.find<AuthRepository>(),
      ),
      fenix: true,
    );
    
    // Add other services here as needed
    // Get.lazyPut<UserService>(() => UserService(), fenix: true);
    // Get.lazyPut<ProjectService>(() => ProjectService(), fenix: true);
    // Get.lazyPut<TaskService>(() => TaskService(), fenix: true);
    // Get.lazyPut<TeamService>(() => TeamService(), fenix: true);
    // Get.lazyPut<OrganizationService>(() => OrganizationService(), fenix: true);
  }
  
  static void _initControllers() {
    // Auth Controller
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
      ),
      fenix: true,
    );
    
    // Add other controllers here as needed
    // Get.lazyPut<UserController>(() => UserController(), fenix: true);
    // Get.lazyPut<ProjectController>(() => ProjectController(), fenix: true);
    // Get.lazyPut<TaskController>(() => TaskController(), fenix: true);
    // Get.lazyPut<TeamController>(() => TeamController(), fenix: true);
    // Get.lazyPut<OrganizationController>(() => OrganizationController(), fenix: true);
    // Get.lazyPut<MainViewController>(() => MainViewController(), fenix: true);
  }
  
  // Helper method to get a dependency
  static T get<T>() {
    return Get.find<T>();
  }
  
  // Helper method to check if dependency is registered
  static bool isRegistered<T>() {
    return Get.isRegistered<T>();
  }
  
  // Helper method to delete a dependency
  static void delete<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>();
    }
  }
  
  // Helper method to delete all dependencies
  static void deleteAll() {
    Get.deleteAll();
  }
}