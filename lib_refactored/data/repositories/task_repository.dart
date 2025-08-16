import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../models/task/task_model.dart';

abstract class TaskRepository {
  Future<ApiResponse<List<TaskModel>>> getAllTasks();
  Future<ApiResponse<TaskModel>> getTaskById(int id);
  Future<ApiResponse<TaskModel>> createTask(Map<String, dynamic> taskData);
  Future<ApiResponse<TaskModel>> updateTask(int id, Map<String, dynamic> taskData);
  Future<ApiResponse<void>> deleteTask(int id);
  Future<ApiResponse<List<TaskModel>>> getTasksByProject(int projectId);
  Future<ApiResponse<List<TaskModel>>> getTasksByStatus(String status);
  Future<ApiResponse<List<TaskModel>>> getTasksByAssignee(int assigneeId);
  Future<ApiResponse<List<TaskModel>>> searchTasks(String query);
  Future<ApiResponse<List<TaskModel>>> getOverdueTasks();
  Future<ApiResponse<TaskModel>> updateTaskStatus(int id, String status);
  Future<ApiResponse<TaskModel>> assignTask(int taskId, int assigneeId);
  Future<ApiResponse<TaskCommentModel>> addComment(int taskId, String content);
  Future<ApiResponse<List<TaskCommentModel>>> getTaskComments(int taskId);
}

class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;
  
  TaskRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;
  
  @override
  Future<ApiResponse<List<TaskModel>>> getAllTasks() async {
    try {
      Logger.logApiRequest('GET', '/tasks');
      
      final response = await _apiClient.get<List<dynamic>>('/tasks');
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Get all tasks failed', error: e);
      return ApiResponse.error('Get all tasks failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskModel>> getTaskById(int id) async {
    try {
      Logger.logApiRequest('GET', '/tasks/$id');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/tasks/$id');
      
      if (response.isSuccess && response.hasData) {
        final task = TaskModel.fromJson(response.data!);
        
        Logger.logApiResponse('GET', '/tasks/$id', 200, data: response.data);
        return ApiResponse.success(task);
      } else {
        Logger.logApiError('GET', '/tasks/$id', response.error ?? 'Unknown error');
        return response.transform((_) => TaskModel());
      }
    } catch (e) {
      Logger.error('Get task by ID failed', error: e);
      return ApiResponse.error('Get task by ID failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskModel>> createTask(Map<String, dynamic> taskData) async {
    try {
      Logger.logApiRequest('POST', '/tasks', data: taskData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/tasks',
        data: taskData,
      );
      
      if (response.isSuccess && response.hasData) {
        final task = TaskModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/tasks', 201, data: response.data);
        return ApiResponse.success(task);
      } else {
        Logger.logApiError('POST', '/tasks', response.error ?? 'Unknown error');
        return response.transform((_) => TaskModel());
      }
    } catch (e) {
      Logger.error('Create task failed', error: e);
      return ApiResponse.error('Create task failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskModel>> updateTask(int id, Map<String, dynamic> taskData) async {
    try {
      Logger.logApiRequest('PUT', '/tasks/$id', data: taskData);
      
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/tasks/$id',
        data: taskData,
      );
      
      if (response.isSuccess && response.hasData) {
        final task = TaskModel.fromJson(response.data!);
        
        Logger.logApiResponse('PUT', '/tasks/$id', 200, data: response.data);
        return ApiResponse.success(task);
      } else {
        Logger.logApiError('PUT', '/tasks/$id', response.error ?? 'Unknown error');
        return response.transform((_) => TaskModel());
      }
    } catch (e) {
      Logger.error('Update task failed', error: e);
      return ApiResponse.error('Update task failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> deleteTask(int id) async {
    try {
      Logger.logApiRequest('DELETE', '/tasks/$id');
      
      final response = await _apiClient.delete<void>('/tasks/$id');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/tasks/$id', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/tasks/$id', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Delete task failed', error: e);
      return ApiResponse.error('Delete task failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskModel>>> getTasksByProject(int projectId) async {
    try {
      Logger.logApiRequest('GET', '/tasks?projectId=$projectId');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/tasks',
        queryParameters: {'projectId': projectId},
      );
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks?projectId=$projectId', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks?projectId=$projectId', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Get tasks by project failed', error: e);
      return ApiResponse.error('Get tasks by project failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskModel>>> getTasksByStatus(String status) async {
    try {
      Logger.logApiRequest('GET', '/tasks?status=$status');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/tasks',
        queryParameters: {'status': status},
      );
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks?status=$status', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks?status=$status', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Get tasks by status failed', error: e);
      return ApiResponse.error('Get tasks by status failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskModel>>> getTasksByAssignee(int assigneeId) async {
    try {
      Logger.logApiRequest('GET', '/tasks?assigneeId=$assigneeId');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/tasks',
        queryParameters: {'assigneeId': assigneeId},
      );
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks?assigneeId=$assigneeId', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks?assigneeId=$assigneeId', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Get tasks by assignee failed', error: e);
      return ApiResponse.error('Get tasks by assignee failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskModel>>> searchTasks(String query) async {
    try {
      Logger.logApiRequest('GET', '/tasks/search?q=$query');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/tasks/search',
        queryParameters: {'q': query},
      );
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks/search?q=$query', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks/search?q=$query', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Search tasks failed', error: e);
      return ApiResponse.error('Search tasks failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskModel>>> getOverdueTasks() async {
    try {
      Logger.logApiRequest('GET', '/tasks/overdue');
      
      final response = await _apiClient.get<List<dynamic>>('/tasks/overdue');
      
      if (response.isSuccess && response.hasData) {
        final tasks = response.data!
            .map((json) => TaskModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks/overdue', 200, data: response.data);
        return ApiResponse.success(tasks);
      } else {
        Logger.logApiError('GET', '/tasks/overdue', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskModel>[]);
      }
    } catch (e) {
      Logger.error('Get overdue tasks failed', error: e);
      return ApiResponse.error('Get overdue tasks failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskModel>> updateTaskStatus(int id, String status) async {
    try {
      Logger.logApiRequest('PATCH', '/tasks/$id/status', data: {'status': status});
      
      final response = await _apiClient.patch<Map<String, dynamic>>(
        '/tasks/$id/status',
        data: {'status': status},
      );
      
      if (response.isSuccess && response.hasData) {
        final task = TaskModel.fromJson(response.data!);
        
        Logger.logApiResponse('PATCH', '/tasks/$id/status', 200, data: response.data);
        return ApiResponse.success(task);
      } else {
        Logger.logApiError('PATCH', '/tasks/$id/status', response.error ?? 'Unknown error');
        return response.transform((_) => TaskModel());
      }
    } catch (e) {
      Logger.error('Update task status failed', error: e);
      return ApiResponse.error('Update task status failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskModel>> assignTask(int taskId, int assigneeId) async {
    try {
      Logger.logApiRequest('PATCH', '/tasks/$taskId/assign', data: {'assigneeId': assigneeId});
      
      final response = await _apiClient.patch<Map<String, dynamic>>(
        '/tasks/$taskId/assign',
        data: {'assigneeId': assigneeId},
      );
      
      if (response.isSuccess && response.hasData) {
        final task = TaskModel.fromJson(response.data!);
        
        Logger.logApiResponse('PATCH', '/tasks/$taskId/assign', 200, data: response.data);
        return ApiResponse.success(task);
      } else {
        Logger.logApiError('PATCH', '/tasks/$taskId/assign', response.error ?? 'Unknown error');
        return response.transform((_) => TaskModel());
      }
    } catch (e) {
      Logger.error('Assign task failed', error: e);
      return ApiResponse.error('Assign task failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TaskCommentModel>> addComment(int taskId, String content) async {
    try {
      Logger.logApiRequest('POST', '/tasks/$taskId/comments', data: {'content': content});
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/tasks/$taskId/comments',
        data: {'content': content},
      );
      
      if (response.isSuccess && response.hasData) {
        final comment = TaskCommentModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/tasks/$taskId/comments', 201, data: response.data);
        return ApiResponse.success(comment);
      } else {
        Logger.logApiError('POST', '/tasks/$taskId/comments', response.error ?? 'Unknown error');
        return response.transform((_) => TaskCommentModel());
      }
    } catch (e) {
      Logger.error('Add task comment failed', error: e);
      return ApiResponse.error('Add task comment failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TaskCommentModel>>> getTaskComments(int taskId) async {
    try {
      Logger.logApiRequest('GET', '/tasks/$taskId/comments');
      
      final response = await _apiClient.get<List<dynamic>>('/tasks/$taskId/comments');
      
      if (response.isSuccess && response.hasData) {
        final comments = response.data!
            .map((json) => TaskCommentModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/tasks/$taskId/comments', 200, data: response.data);
        return ApiResponse.success(comments);
      } else {
        Logger.logApiError('GET', '/tasks/$taskId/comments', response.error ?? 'Unknown error');
        return response.transform((_) => <TaskCommentModel>[]);
      }
    } catch (e) {
      Logger.error('Get task comments failed', error: e);
      return ApiResponse.error('Get task comments failed: $e');
    }
  }
}