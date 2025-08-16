import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/project_controller.dart';
import '../../widgets/project_card.dart';
import '../../widgets/statistics_card.dart';

class ProjectsScreen extends GetView<ProjectController> {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => Column(
        children: [
          // Header with search and filter
          _buildHeader(),
          
          // Statistics cards
          if (controller.projects.isNotEmpty) _buildStatistics(),
          
          // Projects list
          Expanded(
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.filteredProjects.isEmpty
                    ? _buildEmptyState()
                    : _buildProjectsList(),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateProjectDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
            onChanged: (value) => controller.searchProjects(value),
            decoration: InputDecoration(
              hintText: 'Search projects...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: controller.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.searchQuery.value = '';
                        controller.searchProjects('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.cardBackground,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Active', 'active'),
                const SizedBox(width: 8),
                _buildFilterChip('Completed', 'completed'),
                const SizedBox(width: 8),
                _buildFilterChip('On Hold', 'on_hold'),
                const SizedBox(width: 8),
                _buildFilterChip('Cancelled', 'cancelled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String status) {
    final isSelected = controller.selectedStatus.value == status;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        controller.filterProjectsByStatus(status);
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          StatisticsCard(
            title: 'Total',
            value: controller.statistics['totalProjects']?.toString() ?? '0',
            icon: Icons.folder,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          StatisticsCard(
            title: 'Active',
            value: controller.statistics['activeProjects']?.toString() ?? '0',
            icon: Icons.play_circle,
            color: AppColors.success,
          ),
          const SizedBox(width: 12),
          StatisticsCard(
            title: 'Completed',
            value: controller.statistics['completedProjects']?.toString() ?? '0',
            icon: Icons.check_circle,
            color: AppColors.info,
          ),
          const SizedBox(width: 12),
          StatisticsCard(
            title: 'Progress',
            value: '${(controller.statistics['averageProgress'] ?? 0.0).toStringAsFixed(1)}%',
            icon: Icons.trending_up,
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredProjects.length,
      itemBuilder: (context, index) {
        final project = controller.filteredProjects[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ProjectCard(
            project: project,
            onTap: () => _showProjectDetails(project),
            onEdit: () => _showEditProjectDialog(project),
            onDelete: () => _showDeleteConfirmation(project),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: AppTextStyles.h5.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.searchQuery.value.isNotEmpty
                ? 'Try adjusting your search terms'
                : 'Create your first project to get started',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (controller.searchQuery.value.isEmpty)
            ElevatedButton(
              onPressed: () => _showCreateProjectDialog(Get.context!),
              child: const Text('Create Project'),
            ),
        ],
      ),
    );
  }

  void _showCreateProjectDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Create New Project'),
        content: SizedBox(
          width: double.maxFinite,
          child: _buildProjectForm(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: controller.isCreateFormValid && !controller.isLoading.value
                ? () {
                    controller.createProject();
                  }
                : null,
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create'),
          )),
        ],
      ),
    );
  }

  void _showEditProjectDialog(project) {
    controller.loadProjectForEdit(project);
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Project'),
        content: SizedBox(
          width: double.maxFinite,
          child: _buildProjectForm(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: !controller.isLoading.value
                ? () {
                    controller.updateProject(project.id!);
                  }
                : null,
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Update'),
          )),
        ],
      ),
    );
  }

  Widget _buildProjectForm() {
    return Obx(() => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Project Name
        TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
            labelText: 'Project Name',
            errorText: controller.nameError.value,
          ),
          onChanged: (_) => controller.validateName(),
        ),
        
        const SizedBox(height: 16),
        
        // Project Description
        TextFormField(
          controller: controller.descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            errorText: controller.descriptionError.value,
          ),
          maxLines: 3,
          onChanged: (_) => controller.validateDescription(),
        ),
        
        const SizedBox(height: 16),
        
        // Start Date
        TextFormField(
          controller: controller.startDateController,
          decoration: InputDecoration(
            labelText: 'Start Date',
            errorText: controller.startDateError.value,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              controller.startDateController.text = date.toIso8601String().split('T')[0];
              controller.validateStartDate();
            }
          },
        ),
        
        const SizedBox(height: 16),
        
        // End Date
        TextFormField(
          controller: controller.endDateController,
          decoration: InputDecoration(
            labelText: 'End Date (Optional)',
            errorText: controller.endDateError.value,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              controller.endDateController.text = date.toIso8601String().split('T')[0];
              controller.validateEndDate();
            }
          },
        ),
      ],
    ));
  }

  void _showProjectDetails(project) {
    // TODO: Navigate to project details screen
    Logger.info('Show project details: ${project.name}');
  }

  void _showDeleteConfirmation(project) {
    UiUtils.showConfirmationDialog(
      title: 'Delete Project',
      message: 'Are you sure you want to delete "${project.name}"? This action cannot be undone.',
      confirmText: 'Delete',
      confirmColor: AppColors.error,
    ).then((confirmed) {
      if (confirmed) {
        controller.deleteProject(project.id!);
      }
    });
  }
}