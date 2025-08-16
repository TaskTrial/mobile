import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/di/dependency_injection.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/logger.dart';
import 'presentation/app.dart';

Future<void> main() async {
  try {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();
    
    Logger.info('Starting TaskTrial application...');
    
    // Load environment variables
    await dotenv.load(fileName: '.env');
    Logger.info('Environment variables loaded');
    
    // Initialize dependency injection
    await DependencyInjection.init();
    Logger.info('Dependency injection initialized');
    
    // Run the app
    runApp(const TaskTrialApp());
    
    Logger.info('TaskTrial application started successfully');
  } catch (e, stackTrace) {
    Logger.fatal('Failed to start application', error: e, stackTrace: stackTrace);
    rethrow;
  }
}

class TaskTrialApp extends StatelessWidget {
  const TaskTrialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskTrial',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'NunitoSans',
        useMaterial3: true,
      ),
      
      // Route configuration
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      
      // Navigation configuration
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      
      // Error handling
      onUnknownRoute: (settings) {
        Logger.warning('Unknown route: ${settings.name}');
        return GetPageRoute(
          page: () => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
      
      // Builder for global configurations
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}