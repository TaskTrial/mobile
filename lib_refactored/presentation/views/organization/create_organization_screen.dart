import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';

class CreateOrganizationScreen extends StatefulWidget {
  const CreateOrganizationScreen({super.key});

  @override
  State<CreateOrganizationScreen> createState() => _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                
                // Back button
                IconButton(
                  onPressed: () => AppRoutes.goBack(),
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.textPrimary,
                ),
                
                const SizedBox(height: 32),
                
                // Header
                Text(
                  'Create Organization',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Set up your organization to get started',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Organization Form
                _buildOrganizationForm(),
                
                const SizedBox(height: 32),
                
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Join Organization
                Center(
                  child: TextButton(
                    onPressed: () {
                      Logger.logNavigation('CreateOrganizationScreen', 'JoinOrganizationScreen');
                      AppRoutes.goToJoinOrganization();
                    },
                    child: Text(
                      'Join Existing Organization',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizationForm() {
    return Column(
      children: [
        // Organization Name Field
        TextFormField(
          controller: _nameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Organization name is required';
            }
            if (value.trim().length < 3) {
              return 'Organization name must be at least 3 characters';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Organization Name',
            hintText: 'Enter organization name',
            prefixIcon: Icon(Icons.business),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Description Field
        TextFormField(
          controller: _descriptionController,
          textInputAction: TextInputAction.done,
          maxLines: 3,
          onFieldSubmitted: (_) => _handleCreateOrganization(),
          decoration: const InputDecoration(
            labelText: 'Description (Optional)',
            hintText: 'Enter organization description',
            prefixIcon: Icon(Icons.description),
            alignLabelWithHint: true,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Create Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleCreateOrganization,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Create Organization',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    );
  }

  void _handleCreateOrganization() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement organization creation logic
      Logger.info('Creating organization: ${_nameController.text}');
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      UiUtils.showSuccessSnackBar(
        title: 'Success',
        message: 'Organization created successfully!',
      );
      
      // Navigate to main screen
      AppRoutes.goToMain();
    } catch (e) {
      Logger.error('Create organization error', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Creation Failed',
        message: 'Failed to create organization. Please try again.',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}