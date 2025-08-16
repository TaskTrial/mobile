import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/logger.dart';
import '../../domain/models/project/project_model.dart';
import '../../domain/services/project_service.dart';

class ProjectController extends GetxController {
  final ProjectService _projectService;
  
  // Observable variables
  final isLoading = false.obs;
  final projects = <ProjectModel>[].obs;
  final filteredProjects = <ProjectModel>[].obs;
  final selectedProject = Rxn<ProjectModel>();
  final searchQuery = ''.obs;
  final selectedStatus = 'all'.obs;
  
  // Form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  
  // Form validation
  final nameError = Rxn<String>();
  final descriptionError = Rxn<String>();
  final startDateError = Rxn<String>();
  final endDateError = Rxn<String>();
  
  // Statistics
  final statistics = <String, dynamic>{}.obs;
  
  ProjectController({ProjectService? projectService})
      : _projectService = projectService ?? ProjectService();
  
  @override
  void onInit() {
    super.onInit();
    loadProjects();
    Logger.info('ProjectController initialized');
  }
  
  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }
  
  // Load all projects
  Future<void> loadProjects() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    try {
      final projectsList = await _projectService.getAllProjects(
        onError: (error) {
          Logger.error('Load projects error: $error');
        },
      );
      
      projects.value = projectsList;
      filteredProjects.value = projectsList;
      _updateStatistics();
      
      Logger.info('Projects loaded: ${projectsList.length}');
    } catch (e) {
      Logger.error('Load projects controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load project by ID
  Future<void> loadProjectById(int id) async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    try {
      final project = await _projectService.getProjectById(
        id,
        onError: (error) {
          Logger.error('Load project by ID error: $error');
        },
      );
      
      if (project != null) {
        selectedProject.value = project;
        Logger.info('Project loaded: ${project.name}');
      }
    } catch (e) {
      Logger.error('Load project by ID controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Create project
  Future<void> createProject() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final startDate = DateTime.tryParse(startDateController.text);
      final endDate = endDateController.text.isNotEmpty 
          ? DateTime.tryParse(endDateController.text) 
          : null;
      
      if (startDate == null) {
        startDateError.value = 'Please select a valid start date';
        isLoading.value = false;
        return;
      }
      
      final success = await _projectService.createProject(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        startDate: startDate,
        endDate: endDate,
        onSuccess: (project) {
          Logger.info('Project created successfully');
          projects.add(project);
          _updateStatistics();
          _clearFormData();
          Get.back(); // Close create project screen
        },
        onError: (error) {
          Logger.error('Create project error: $error');
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('Create project controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Update project
  Future<void> updateProject(int id) async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final startDate = startDateController.text.isNotEmpty 
          ? DateTime.tryParse(startDateController.text) 
          : null;
      final endDate = endDateController.text.isNotEmpty 
          ? DateTime.tryParse(endDateController.text) 
          : null;
      
      final success = await _projectService.updateProject(
        id: id,
        name: nameController.text.trim().isNotEmpty ? nameController.text.trim() : null,
        description: descriptionController.text.trim().isNotEmpty ? descriptionController.text.trim() : null,
        startDate: startDate,
        endDate: endDate,
        onSuccess: (project) {
          Logger.info('Project updated successfully');
          final index = projects.indexWhere((p) => p.id == id);
          if (index != -1) {
            projects[index] = project;
            _updateStatistics();
          }
          _clearFormData();
          Get.back(); // Close edit project screen
        },
        onError: (error) {
          Logger.error('Update project error: $error');
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('Update project controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Delete project
  Future<void> deleteProject(int id) async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    try {
      final success = await _projectService.deleteProject(
        id: id,
        onSuccess: () {
          Logger.info('Project deleted successfully');
          projects.removeWhere((p) => p.id == id);
          _updateStatistics();
        },
        onError: (error) {
          Logger.error('Delete project error: $error');
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('Delete project controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Search projects
  Future<void> searchProjects(String query) async {
    searchQuery.value = query;
    
    if (query.trim().isEmpty) {
      filteredProjects.value = projects;
      return;
    }
    
    try {
      final searchResults = await _projectService.searchProjects(
        query,
        onError: (error) {
          Logger.error('Search projects error: $error');
        },
      );
      
      filteredProjects.value = searchResults;
      Logger.info('Search completed: ${searchResults.length} results');
    } catch (e) {
      Logger.error('Search projects controller error', error: e);
    }
  }
  
  // Filter projects by status
  void filterProjectsByStatus(String status) {
    selectedStatus.value = status;
    
    if (status == 'all') {
      filteredProjects.value = projects;
    } else {
      filteredProjects.value = projects.where((p) => p.status == status).toList();
    }
    
    Logger.info('Projects filtered by status: $status');
  }
  
  // Load project for editing
  void loadProjectForEdit(ProjectModel project) {
    selectedProject.value = project;
    nameController.text = project.name ?? '';
    descriptionController.text = project.description ?? '';
    startDateController.text = project.startDate?.toIso8601String().split('T')[0] ?? '';
    endDateController.text = project.endDate?.toIso8601String().split('T')[0] ?? '';
  }
  
  // Form validation methods
  void validateName() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      nameError.value = 'Project name is required';
    } else if (name.length < 3) {
      nameError.value = 'Project name must be at least 3 characters';
    } else {
      nameError.value = null;
    }
  }
  
  void validateDescription() {
    final description = descriptionController.text.trim();
    if (description.isEmpty) {
      descriptionError.value = 'Project description is required';
    } else if (description.length < 10) {
      descriptionError.value = 'Project description must be at least 10 characters';
    } else {
      descriptionError.value = null;
    }
  }
  
  void validateStartDate() {
    final startDate = startDateController.text;
    if (startDate.isEmpty) {
      startDateError.value = 'Start date is required';
    } else if (DateTime.tryParse(startDate) == null) {
      startDateError.value = 'Please enter a valid date';
    } else {
      startDateError.value = null;
    }
  }
  
  void validateEndDate() {
    final endDate = endDateController.text;
    if (endDate.isNotEmpty) {
      final endDateParsed = DateTime.tryParse(endDate);
      final startDateParsed = DateTime.tryParse(startDateController.text);
      
      if (endDateParsed == null) {
        endDateError.value = 'Please enter a valid date';
      } else if (startDateParsed != null && endDateParsed.isBefore(startDateParsed)) {
        endDateError.value = 'End date cannot be before start date';
      } else {
        endDateError.value = null;
      }
    } else {
      endDateError.value = null;
    }
  }
  
  // Clear all form errors
  void _clearErrors() {
    nameError.value = null;
    descriptionError.value = null;
    startDateError.value = null;
    endDateError.value = null;
  }
  
  // Clear form data
  void _clearFormData() {
    nameController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedProject.value = null;
    _clearErrors();
  }
  
  // Update statistics
  void _updateStatistics() {
    statistics.value = _projectService.getProjectStatistics(projects);
  }
  
  // Check if form is valid
  bool get isCreateFormValid {
    return nameController.text.trim().isNotEmpty &&
           descriptionController.text.trim().isNotEmpty &&
           startDateController.text.isNotEmpty &&
           nameError.value == null &&
           descriptionError.value == null &&
           startDateError.value == null &&
           endDateError.value == null;
  }
  
  // Get projects by status for statistics
  List<ProjectModel> get activeProjects => projects.where((p) => p.isActive).toList();
  List<ProjectModel> get completedProjects => projects.where((p) => p.isCompleted).toList();
  List<ProjectModel> get onHoldProjects => projects.where((p) => p.isOnHold).toList();
  List<ProjectModel> get cancelledProjects => projects.where((p) => p.isCancelled).toList();
}