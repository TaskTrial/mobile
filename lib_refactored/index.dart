// Core exports
export 'core/constants/app_constants.dart';
export 'core/constants/app_colors.dart';
export 'core/constants/app_text_styles.dart';
export 'core/di/dependency_injection.dart';
export 'core/network/api_client.dart';
export 'core/network/api_response.dart';
export 'core/network/api_interceptor.dart';
export 'core/routes/app_routes.dart';
export 'core/storage/local_storage.dart';
export 'core/utils/logger.dart';
export 'core/utils/validators.dart';
export 'core/utils/ui_utils.dart';

// Data layer exports
export 'data/models/auth/login_model.dart';
export 'data/models/auth/user_model.dart';
export 'data/models/project/project_model.dart';
export 'data/repositories/auth_repository.dart';
export 'data/repositories/project_repository.dart';

// Domain layer exports
export 'domain/models/auth/login_model.dart';
export 'domain/models/auth/user_model.dart';
export 'domain/models/project/project_model.dart';
export 'domain/services/auth_service.dart';
export 'domain/services/project_service.dart';

// Presentation layer exports
export 'presentation/controllers/auth_controller.dart';
export 'presentation/controllers/project_controller.dart';
export 'presentation/views/splash_screen.dart';
export 'presentation/views/landing_screen.dart';
export 'presentation/views/auth/login_screen.dart';
export 'presentation/views/auth/register_screen.dart';
export 'presentation/views/auth/forgot_password_screen.dart';
export 'presentation/views/auth/verify_otp_screen.dart';
export 'presentation/views/auth/reset_password_screen.dart';
export 'presentation/views/organization/create_organization_screen.dart';
export 'presentation/views/organization/join_organization_screen.dart';
export 'presentation/views/project/projects_screen.dart';
export 'presentation/views/main_view_screen.dart';
export 'presentation/widgets/project_card.dart';
export 'presentation/widgets/statistics_card.dart';
export 'presentation/app.dart';

// Main entry point
export 'main.dart';