import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/ui_utils.dart';
import '../../core/utils/validators.dart';
import '../../data/repositories/project_repository.dart';
import '../models/project/project_model.dart';

class ProjectService {
  final ProjectRepository _projectRepository;
  
  ProjectService({ProjectRepository? projectRepository})
      : _projectRepository = projectRepository ?? ProjectRepositoryImpl();
  
  // Get all projects
  Future<List<ProjectModel>> getAllProjects({
    Function(String)? onError,
  }) async {
    try {
      Logger.info('Fetching all projects');
      
      final response = await _projectRepository.getAllProjects();
      
      return response.fold(
        onSuccess: (projects) {
          Logger.info('Successfully fetched ${projects.length} projects');
          return projects;
        },
        onError: (error) {
          Logger.error('Get all projects failed: $error');
          onError?.call(error);
          return <ProjectModel>[];
        },
      );
    } catch (e) {
      Logger.error('Get all projects service error', error: e);
      onError?.call('An unexpected error occurred');
      return <ProjectModel>[];
    }
  }
  
  // Get project by ID
  Future<ProjectModel?> getProjectById(int id, {
    Function(String)? onError,
  }) async {
    try {
      Logger.info('Fetching project with ID: $id');
      
      final response = await _projectRepository.getProjectById(id);
      
      return response.fold(
        onSuccess: (project) {
          Logger.info('Successfully fetched project: ${project.name}');
          return project;
        },
        onError: (error) {
          Logger.error('Get project by ID failed: $error');
          onError?.call(error);
          return null;
        },
      );
    } catch (e) {
      Logger.error('Get project by ID service error', error: e);
      onError?.call('An unexpected error occurred');
      return null;
    }
  }
  
  // Create project
  Future<bool> createProject({
    required String name,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
    required Function(ProjectModel) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Validate inputs
      final nameError = Validators.validateRequired(name, 'Project name');
      if (nameError != null) {
        onError(nameError);
        return false;
      }
      
      final descriptionError = Validators.validateRequired(description, 'Project description');
      if (descriptionError != null) {
        onError(descriptionError);
        return false;
      }
      
      if (endDate != null && endDate.isBefore(startDate)) {
        onError('End date cannot be before start date');
        return false;
      }
      
      Logger.info('Creating project: $name');
      
      final projectData = {
        'name': name,
        'description': description,
        'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        'status': 'active',
      };
      
      final response = await _projectRepository.createProject(projectData);
      
      return response.fold(
        onSuccess: (project) {
          Logger.info('Project created successfully: ${project.name}');
          onSuccess(project);
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Project created successfully!',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Create project failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Creation Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Create project service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Update project
  Future<bool> updateProject({
    required int id,
    String? name,
    String? description,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    required Function(ProjectModel) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      Logger.info('Updating project with ID: $id');
      
      final projectData = <String, dynamic>{};
      if (name != null) projectData['name'] = name;
      if (description != null) projectData['description'] = description;
      if (status != null) projectData['status'] = status;
      if (startDate != null) projectData['startDate'] = startDate.toIso8601String();
      if (endDate != null) projectData['endDate'] = endDate.toIso8601String();
      
      if (projectData.isEmpty) {
        onError('No data provided for update');
        return false;
      }
      
      final response = await _projectRepository.updateProject(id, projectData);
      
      return response.fold(
        onSuccess: (project) {
          Logger.info('Project updated successfully: ${project.name}');
          onSuccess(project);
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Project updated successfully!',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Update project failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Update Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Update project service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Delete project
  Future<bool> deleteProject({
    required int id,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      Logger.info('Deleting project with ID: $id');
      
      final response = await _projectRepository.deleteProject(id);
      
      return response.fold(
        onSuccess: (_) {
          Logger.info('Project deleted successfully');
          onSuccess();
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Project deleted successfully!',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Delete project failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Deletion Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Delete project service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Get projects by status
  Future<List<ProjectModel>> getProjectsByStatus(String status, {
    Function(String)? onError,
  }) async {
    try {
      Logger.info('Fetching projects with status: $status');
      
      final response = await _projectRepository.getProjectsByStatus(status);
      
      return response.fold(
        onSuccess: (projects) {
          Logger.info('Successfully fetched ${projects.length} projects with status: $status');
          return projects;
        },
        onError: (error) {
          Logger.error('Get projects by status failed: $error');
          onError?.call(error);
          return <ProjectModel>[];
        },
      );
    } catch (e) {
      Logger.error('Get projects by status service error', error: e);
      onError?.call('An unexpected error occurred');
      return <ProjectModel>[];
    }
  }
  
  // Search projects
  Future<List<ProjectModel>> searchProjects(String query, {
    Function(String)? onError,
  }) async {
    try {
      if (query.trim().isEmpty) {
        return <ProjectModel>[];
      }
      
      Logger.info('Searching projects with query: $query');
      
      final response = await _projectRepository.searchProjects(query);
      
      return response.fold(
        onSuccess: (projects) {
          Logger.info('Found ${projects.length} projects matching query: $query');
          return projects;
        },
        onError: (error) {
          Logger.error('Search projects failed: $error');
          onError?.call(error);
          return <ProjectModel>[];
        },
      );
    } catch (e) {
      Logger.error('Search projects service error', error: e);
      onError?.call('An unexpected error occurred');
      return <ProjectModel>[];
    }
  }
  
  // Get project statistics
  Map<String, dynamic> getProjectStatistics(List<ProjectModel> projects) {
    final totalProjects = projects.length;
    final activeProjects = projects.where((p) => p.isActive).length;
    final completedProjects = projects.where((p) => p.isCompleted).length;
    final onHoldProjects = projects.where((p) => p.isOnHold).length;
    final cancelledProjects = projects.where((p) => p.isCancelled).length;
    
    final totalTasks = projects.fold<int>(0, (sum, p) => sum + (p.totalTasks ?? 0));
    final completedTasks = projects.fold<int>(0, (sum, p) => sum + (p.completedTasks ?? 0));
    
    final averageProgress = totalProjects > 0 
        ? projects.fold<double>(0, (sum, p) => sum + p.progressPercentage) / totalProjects
        : 0.0;
    
    return {
      'totalProjects': totalProjects,
      'activeProjects': activeProjects,
      'completedProjects': completedProjects,
      'onHoldProjects': onHoldProjects,
      'cancelledProjects': cancelledProjects,
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'averageProgress': averageProgress,
    };
  }
}