import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';

class JoinOrganizationScreen extends StatefulWidget {
  const JoinOrganizationScreen({super.key});

  @override
  State<JoinOrganizationScreen> createState() => _JoinOrganizationScreenState();
}

class _JoinOrganizationScreenState extends State<JoinOrganizationScreen> {
  final TextEditingController _inviteCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
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
                  'Join Organization',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Enter the invite code to join an organization',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Join Form
                _buildJoinForm(),
                
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
                
                // Create Organization
                Center(
                  child: TextButton(
                    onPressed: () {
                      Logger.logNavigation('JoinOrganizationScreen', 'CreateOrganizationScreen');
                      AppRoutes.goBack();
                    },
                    child: Text(
                      'Create New Organization',
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

  Widget _buildJoinForm() {
    return Column(
      children: [
        // Invite Code Field
        TextFormField(
          controller: _inviteCodeController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleJoinOrganization(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Invite code is required';
            }
            if (value.trim().length < 6) {
              return 'Invite code must be at least 6 characters';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Invite Code',
            hintText: 'Enter organization invite code',
            prefixIcon: Icon(Icons.invite),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Join Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleJoinOrganization,
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
                    'Join Organization',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Info Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.info.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ask your organization admin for the invite code to join their workspace.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleJoinOrganization() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement organization joining logic
      Logger.info('Joining organization with code: ${_inviteCodeController.text}');
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      UiUtils.showSuccessSnackBar(
        title: 'Success',
        message: 'Successfully joined the organization!',
      );
      
      // Navigate to main screen
      AppRoutes.goToMain();
    } catch (e) {
      Logger.error('Join organization error', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Join Failed',
        message: 'Failed to join organization. Please check the invite code and try again.',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}