import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../models/team/team_model.dart';

abstract class TeamRepository {
  Future<ApiResponse<List<TeamModel>>> getAllTeams();
  Future<ApiResponse<TeamModel>> getTeamById(int id);
  Future<ApiResponse<TeamModel>> createTeam(Map<String, dynamic> teamData);
  Future<ApiResponse<TeamModel>> updateTeam(int id, Map<String, dynamic> teamData);
  Future<ApiResponse<void>> deleteTeam(int id);
  Future<ApiResponse<List<TeamModel>>> getTeamsByOrganization(int organizationId);
  Future<ApiResponse<List<TeamModel>>> getTeamsByStatus(String status);
  Future<ApiResponse<List<TeamModel>>> searchTeams(String query);
  Future<ApiResponse<TeamMemberModel>> addMember(int teamId, int userId, String role);
  Future<ApiResponse<void>> removeMember(int teamId, int userId);
  Future<ApiResponse<TeamMemberModel>> updateMemberRole(int teamId, int userId, String role);
  Future<ApiResponse<List<TeamMemberModel>>> getTeamMembers(int teamId);
  Future<ApiResponse<void>> assignProject(int teamId, int projectId);
  Future<ApiResponse<void>> unassignProject(int teamId, int projectId);
  Future<ApiResponse<List<TeamProjectModel>>> getTeamProjects(int teamId);
}

class TeamRepositoryImpl implements TeamRepository {
  final ApiClient _apiClient;
  
  TeamRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;
  
  @override
  Future<ApiResponse<List<TeamModel>>> getAllTeams() async {
    try {
      Logger.logApiRequest('GET', '/teams');
      
      final response = await _apiClient.get<List<dynamic>>('/teams');
      
      if (response.isSuccess && response.hasData) {
        final teams = response.data!
            .map((json) => TeamModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams', 200, data: response.data);
        return ApiResponse.success(teams);
      } else {
        Logger.logApiError('GET', '/teams', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamModel>[]);
      }
    } catch (e) {
      Logger.error('Get all teams failed', error: e);
      return ApiResponse.error('Get all teams failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TeamModel>> getTeamById(int id) async {
    try {
      Logger.logApiRequest('GET', '/teams/$id');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/teams/$id');
      
      if (response.isSuccess && response.hasData) {
        final team = TeamModel.fromJson(response.data!);
        
        Logger.logApiResponse('GET', '/teams/$id', 200, data: response.data);
        return ApiResponse.success(team);
      } else {
        Logger.logApiError('GET', '/teams/$id', response.error ?? 'Unknown error');
        return response.transform((_) => TeamModel());
      }
    } catch (e) {
      Logger.error('Get team by ID failed', error: e);
      return ApiResponse.error('Get team by ID failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TeamModel>> createTeam(Map<String, dynamic> teamData) async {
    try {
      Logger.logApiRequest('POST', '/teams', data: teamData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/teams',
        data: teamData,
      );
      
      if (response.isSuccess && response.hasData) {
        final team = TeamModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/teams', 201, data: response.data);
        return ApiResponse.success(team);
      } else {
        Logger.logApiError('POST', '/teams', response.error ?? 'Unknown error');
        return response.transform((_) => TeamModel());
      }
    } catch (e) {
      Logger.error('Create team failed', error: e);
      return ApiResponse.error('Create team failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TeamModel>> updateTeam(int id, Map<String, dynamic> teamData) async {
    try {
      Logger.logApiRequest('PUT', '/teams/$id', data: teamData);
      
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/teams/$id',
        data: teamData,
      );
      
      if (response.isSuccess && response.hasData) {
        final team = TeamModel.fromJson(response.data!);
        
        Logger.logApiResponse('PUT', '/teams/$id', 200, data: response.data);
        return ApiResponse.success(team);
      } else {
        Logger.logApiError('PUT', '/teams/$id', response.error ?? 'Unknown error');
        return response.transform((_) => TeamModel());
      }
    } catch (e) {
      Logger.error('Update team failed', error: e);
      return ApiResponse.error('Update team failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> deleteTeam(int id) async {
    try {
      Logger.logApiRequest('DELETE', '/teams/$id');
      
      final response = await _apiClient.delete<void>('/teams/$id');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/teams/$id', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/teams/$id', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Delete team failed', error: e);
      return ApiResponse.error('Delete team failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TeamModel>>> getTeamsByOrganization(int organizationId) async {
    try {
      Logger.logApiRequest('GET', '/teams?organizationId=$organizationId');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/teams',
        queryParameters: {'organizationId': organizationId},
      );
      
      if (response.isSuccess && response.hasData) {
        final teams = response.data!
            .map((json) => TeamModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams?organizationId=$organizationId', 200, data: response.data);
        return ApiResponse.success(teams);
      } else {
        Logger.logApiError('GET', '/teams?organizationId=$organizationId', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamModel>[]);
      }
    } catch (e) {
      Logger.error('Get teams by organization failed', error: e);
      return ApiResponse.error('Get teams by organization failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TeamModel>>> getTeamsByStatus(String status) async {
    try {
      Logger.logApiRequest('GET', '/teams?status=$status');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/teams',
        queryParameters: {'status': status},
      );
      
      if (response.isSuccess && response.hasData) {
        final teams = response.data!
            .map((json) => TeamModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams?status=$status', 200, data: response.data);
        return ApiResponse.success(teams);
      } else {
        Logger.logApiError('GET', '/teams?status=$status', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamModel>[]);
      }
    } catch (e) {
      Logger.error('Get teams by status failed', error: e);
      return ApiResponse.error('Get teams by status failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TeamModel>>> searchTeams(String query) async {
    try {
      Logger.logApiRequest('GET', '/teams/search?q=$query');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/teams/search',
        queryParameters: {'q': query},
      );
      
      if (response.isSuccess && response.hasData) {
        final teams = response.data!
            .map((json) => TeamModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams/search?q=$query', 200, data: response.data);
        return ApiResponse.success(teams);
      } else {
        Logger.logApiError('GET', '/teams/search?q=$query', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamModel>[]);
      }
    } catch (e) {
      Logger.error('Search teams failed', error: e);
      return ApiResponse.error('Search teams failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TeamMemberModel>> addMember(int teamId, int userId, String role) async {
    try {
      Logger.logApiRequest('POST', '/teams/$teamId/members', data: {'userId': userId, 'role': role});
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/teams/$teamId/members',
        data: {'userId': userId, 'role': role},
      );
      
      if (response.isSuccess && response.hasData) {
        final member = TeamMemberModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/teams/$teamId/members', 201, data: response.data);
        return ApiResponse.success(member);
      } else {
        Logger.logApiError('POST', '/teams/$teamId/members', response.error ?? 'Unknown error');
        return response.transform((_) => TeamMemberModel());
      }
    } catch (e) {
      Logger.error('Add team member failed', error: e);
      return ApiResponse.error('Add team member failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> removeMember(int teamId, int userId) async {
    try {
      Logger.logApiRequest('DELETE', '/teams/$teamId/members/$userId');
      
      final response = await _apiClient.delete<void>('/teams/$teamId/members/$userId');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/teams/$teamId/members/$userId', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/teams/$teamId/members/$userId', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Remove team member failed', error: e);
      return ApiResponse.error('Remove team member failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<TeamMemberModel>> updateMemberRole(int teamId, int userId, String role) async {
    try {
      Logger.logApiRequest('PATCH', '/teams/$teamId/members/$userId/role', data: {'role': role});
      
      final response = await _apiClient.patch<Map<String, dynamic>>(
        '/teams/$teamId/members/$userId/role',
        data: {'role': role},
      );
      
      if (response.isSuccess && response.hasData) {
        final member = TeamMemberModel.fromJson(response.data!);
        
        Logger.logApiResponse('PATCH', '/teams/$teamId/members/$userId/role', 200, data: response.data);
        return ApiResponse.success(member);
      } else {
        Logger.logApiError('PATCH', '/teams/$teamId/members/$userId/role', response.error ?? 'Unknown error');
        return response.transform((_) => TeamMemberModel());
      }
    } catch (e) {
      Logger.error('Update team member role failed', error: e);
      return ApiResponse.error('Update team member role failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TeamMemberModel>>> getTeamMembers(int teamId) async {
    try {
      Logger.logApiRequest('GET', '/teams/$teamId/members');
      
      final response = await _apiClient.get<List<dynamic>>('/teams/$teamId/members');
      
      if (response.isSuccess && response.hasData) {
        final members = response.data!
            .map((json) => TeamMemberModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams/$teamId/members', 200, data: response.data);
        return ApiResponse.success(members);
      } else {
        Logger.logApiError('GET', '/teams/$teamId/members', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamMemberModel>[]);
      }
    } catch (e) {
      Logger.error('Get team members failed', error: e);
      return ApiResponse.error('Get team members failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> assignProject(int teamId, int projectId) async {
    try {
      Logger.logApiRequest('POST', '/teams/$teamId/projects', data: {'projectId': projectId});
      
      final response = await _apiClient.post<void>(
        '/teams/$teamId/projects',
        data: {'projectId': projectId},
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/teams/$teamId/projects', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/teams/$teamId/projects', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Assign project to team failed', error: e);
      return ApiResponse.error('Assign project to team failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> unassignProject(int teamId, int projectId) async {
    try {
      Logger.logApiRequest('DELETE', '/teams/$teamId/projects/$projectId');
      
      final response = await _apiClient.delete<void>('/teams/$teamId/projects/$projectId');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/teams/$teamId/projects/$projectId', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/teams/$teamId/projects/$projectId', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Unassign project from team failed', error: e);
      return ApiResponse.error('Unassign project from team failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<TeamProjectModel>>> getTeamProjects(int teamId) async {
    try {
      Logger.logApiRequest('GET', '/teams/$teamId/projects');
      
      final response = await _apiClient.get<List<dynamic>>('/teams/$teamId/projects');
      
      if (response.isSuccess && response.hasData) {
        final projects = response.data!
            .map((json) => TeamProjectModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/teams/$teamId/projects', 200, data: response.data);
        return ApiResponse.success(projects);
      } else {
        Logger.logApiError('GET', '/teams/$teamId/projects', response.error ?? 'Unknown error');
        return response.transform((_) => <TeamProjectModel>[]);
      }
    } catch (e) {
      Logger.error('Get team projects failed', error: e);
      return ApiResponse.error('Get team projects failed: $e');
    }
  }
}