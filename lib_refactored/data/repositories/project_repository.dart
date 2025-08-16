import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../models/project/project_model.dart';

abstract class ProjectRepository {
  Future<ApiResponse<List<ProjectModel>>> getAllProjects();
  Future<ApiResponse<ProjectModel>> getProjectById(int id);
  Future<ApiResponse<ProjectModel>> createProject(Map<String, dynamic> projectData);
  Future<ApiResponse<ProjectModel>> updateProject(int id, Map<String, dynamic> projectData);
  Future<ApiResponse<void>> deleteProject(int id);
  Future<ApiResponse<List<ProjectModel>>> getProjectsByStatus(String status);
  Future<ApiResponse<List<ProjectModel>>> searchProjects(String query);
}

class ProjectRepositoryImpl implements ProjectRepository {
  final ApiClient _apiClient;
  
  ProjectRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;
  
  @override
  Future<ApiResponse<List<ProjectModel>>> getAllProjects() async {
    try {
      Logger.logApiRequest('GET', '/projects');
      
      final response = await _apiClient.get<List<dynamic>>('/projects');
      
      if (response.isSuccess && response.hasData) {
        final projects = response.data!
            .map((json) => ProjectModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/projects', 200, data: response.data);
        return ApiResponse.success(projects);
      } else {
        Logger.logApiError('GET', '/projects', response.error ?? 'Unknown error');
        return response.transform((_) => <ProjectModel>[]);
      }
    } catch (e) {
      Logger.error('Get all projects failed', error: e);
      return ApiResponse.error('Get all projects failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ProjectModel>> getProjectById(int id) async {
    try {
      Logger.logApiRequest('GET', '/projects/$id');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/projects/$id');
      
      if (response.isSuccess && response.hasData) {
        final project = ProjectModel.fromJson(response.data!);
        
        Logger.logApiResponse('GET', '/projects/$id', 200, data: response.data);
        return ApiResponse.success(project);
      } else {
        Logger.logApiError('GET', '/projects/$id', response.error ?? 'Unknown error');
        return response.transform((_) => ProjectModel());
      }
    } catch (e) {
      Logger.error('Get project by ID failed', error: e);
      return ApiResponse.error('Get project by ID failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ProjectModel>> createProject(Map<String, dynamic> projectData) async {
    try {
      Logger.logApiRequest('POST', '/projects', data: projectData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/projects',
        data: projectData,
      );
      
      if (response.isSuccess && response.hasData) {
        final project = ProjectModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/projects', 201, data: response.data);
        return ApiResponse.success(project);
      } else {
        Logger.logApiError('POST', '/projects', response.error ?? 'Unknown error');
        return response.transform((_) => ProjectModel());
      }
    } catch (e) {
      Logger.error('Create project failed', error: e);
      return ApiResponse.error('Create project failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ProjectModel>> updateProject(int id, Map<String, dynamic> projectData) async {
    try {
      Logger.logApiRequest('PUT', '/projects/$id', data: projectData);
      
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/projects/$id',
        data: projectData,
      );
      
      if (response.isSuccess && response.hasData) {
        final project = ProjectModel.fromJson(response.data!);
        
        Logger.logApiResponse('PUT', '/projects/$id', 200, data: response.data);
        return ApiResponse.success(project);
      } else {
        Logger.logApiError('PUT', '/projects/$id', response.error ?? 'Unknown error');
        return response.transform((_) => ProjectModel());
      }
    } catch (e) {
      Logger.error('Update project failed', error: e);
      return ApiResponse.error('Update project failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> deleteProject(int id) async {
    try {
      Logger.logApiRequest('DELETE', '/projects/$id');
      
      final response = await _apiClient.delete<void>('/projects/$id');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/projects/$id', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/projects/$id', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Delete project failed', error: e);
      return ApiResponse.error('Delete project failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<ProjectModel>>> getProjectsByStatus(String status) async {
    try {
      Logger.logApiRequest('GET', '/projects?status=$status');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/projects',
        queryParameters: {'status': status},
      );
      
      if (response.isSuccess && response.hasData) {
        final projects = response.data!
            .map((json) => ProjectModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/projects?status=$status', 200, data: response.data);
        return ApiResponse.success(projects);
      } else {
        Logger.logApiError('GET', '/projects?status=$status', response.error ?? 'Unknown error');
        return response.transform((_) => <ProjectModel>[]);
      }
    } catch (e) {
      Logger.error('Get projects by status failed', error: e);
      return ApiResponse.error('Get projects by status failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<ProjectModel>>> searchProjects(String query) async {
    try {
      Logger.logApiRequest('GET', '/projects/search?q=$query');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/projects/search',
        queryParameters: {'q': query},
      );
      
      if (response.isSuccess && response.hasData) {
        final projects = response.data!
            .map((json) => ProjectModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/projects/search?q=$query', 200, data: response.data);
        return ApiResponse.success(projects);
      } else {
        Logger.logApiError('GET', '/projects/search?q=$query', response.error ?? 'Unknown error');
        return response.transform((_) => <ProjectModel>[]);
      }
    } catch (e) {
      Logger.error('Search projects failed', error: e);
      return ApiResponse.error('Search projects failed: $e');
    }
  }
}