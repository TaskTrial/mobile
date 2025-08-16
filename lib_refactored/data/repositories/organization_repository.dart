import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../models/organization/organization_model.dart';

abstract class OrganizationRepository {
  Future<ApiResponse<List<OrganizationModel>>> getAllOrganizations();
  Future<ApiResponse<OrganizationModel>> getOrganizationById(int id);
  Future<ApiResponse<OrganizationModel>> createOrganization(Map<String, dynamic> organizationData);
  Future<ApiResponse<OrganizationModel>> updateOrganization(int id, Map<String, dynamic> organizationData);
  Future<ApiResponse<void>> deleteOrganization(int id);
  Future<ApiResponse<List<OrganizationModel>>> getOrganizationsByStatus(String status);
  Future<ApiResponse<List<OrganizationModel>>> searchOrganizations(String query);
  Future<ApiResponse<OrganizationMemberModel>> addMember(int organizationId, int userId, String role);
  Future<ApiResponse<void>> removeMember(int organizationId, int userId);
  Future<ApiResponse<OrganizationMemberModel>> updateMemberRole(int organizationId, int userId, String role);
  Future<ApiResponse<List<OrganizationMemberModel>>> getOrganizationMembers(int organizationId);
  Future<ApiResponse<void>> inviteMember(int organizationId, String email, String role);
  Future<ApiResponse<void>> acceptInvitation(String invitationToken);
  Future<ApiResponse<void>> declineInvitation(String invitationToken);
  Future<ApiResponse<Map<String, dynamic>>> getOrganizationSettings(int organizationId);
  Future<ApiResponse<void>> updateOrganizationSettings(int organizationId, Map<String, dynamic> settings);
}

class OrganizationRepositoryImpl implements OrganizationRepository {
  final ApiClient _apiClient;
  
  OrganizationRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;
  
  @override
  Future<ApiResponse<List<OrganizationModel>>> getAllOrganizations() async {
    try {
      Logger.logApiRequest('GET', '/organizations');
      
      final response = await _apiClient.get<List<dynamic>>('/organizations');
      
      if (response.isSuccess && response.hasData) {
        final organizations = response.data!
            .map((json) => OrganizationModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/organizations', 200, data: response.data);
        return ApiResponse.success(organizations);
      } else {
        Logger.logApiError('GET', '/organizations', response.error ?? 'Unknown error');
        return response.transform((_) => <OrganizationModel>[]);
      }
    } catch (e) {
      Logger.error('Get all organizations failed', error: e);
      return ApiResponse.error('Get all organizations failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<OrganizationModel>> getOrganizationById(int id) async {
    try {
      Logger.logApiRequest('GET', '/organizations/$id');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/organizations/$id');
      
      if (response.isSuccess && response.hasData) {
        final organization = OrganizationModel.fromJson(response.data!);
        
        Logger.logApiResponse('GET', '/organizations/$id', 200, data: response.data);
        return ApiResponse.success(organization);
      } else {
        Logger.logApiError('GET', '/organizations/$id', response.error ?? 'Unknown error');
        return response.transform((_) => OrganizationModel());
      }
    } catch (e) {
      Logger.error('Get organization by ID failed', error: e);
      return ApiResponse.error('Get organization by ID failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<OrganizationModel>> createOrganization(Map<String, dynamic> organizationData) async {
    try {
      Logger.logApiRequest('POST', '/organizations', data: organizationData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/organizations',
        data: organizationData,
      );
      
      if (response.isSuccess && response.hasData) {
        final organization = OrganizationModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/organizations', 201, data: response.data);
        return ApiResponse.success(organization);
      } else {
        Logger.logApiError('POST', '/organizations', response.error ?? 'Unknown error');
        return response.transform((_) => OrganizationModel());
      }
    } catch (e) {
      Logger.error('Create organization failed', error: e);
      return ApiResponse.error('Create organization failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<OrganizationModel>> updateOrganization(int id, Map<String, dynamic> organizationData) async {
    try {
      Logger.logApiRequest('PUT', '/organizations/$id', data: organizationData);
      
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/organizations/$id',
        data: organizationData,
      );
      
      if (response.isSuccess && response.hasData) {
        final organization = OrganizationModel.fromJson(response.data!);
        
        Logger.logApiResponse('PUT', '/organizations/$id', 200, data: response.data);
        return ApiResponse.success(organization);
      } else {
        Logger.logApiError('PUT', '/organizations/$id', response.error ?? 'Unknown error');
        return response.transform((_) => OrganizationModel());
      }
    } catch (e) {
      Logger.error('Update organization failed', error: e);
      return ApiResponse.error('Update organization failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> deleteOrganization(int id) async {
    try {
      Logger.logApiRequest('DELETE', '/organizations/$id');
      
      final response = await _apiClient.delete<void>('/organizations/$id');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/organizations/$id', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/organizations/$id', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Delete organization failed', error: e);
      return ApiResponse.error('Delete organization failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<OrganizationModel>>> getOrganizationsByStatus(String status) async {
    try {
      Logger.logApiRequest('GET', '/organizations?status=$status');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/organizations',
        queryParameters: {'status': status},
      );
      
      if (response.isSuccess && response.hasData) {
        final organizations = response.data!
            .map((json) => OrganizationModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/organizations?status=$status', 200, data: response.data);
        return ApiResponse.success(organizations);
      } else {
        Logger.logApiError('GET', '/organizations?status=$status', response.error ?? 'Unknown error');
        return response.transform((_) => <OrganizationModel>[]);
      }
    } catch (e) {
      Logger.error('Get organizations by status failed', error: e);
      return ApiResponse.error('Get organizations by status failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<OrganizationModel>>> searchOrganizations(String query) async {
    try {
      Logger.logApiRequest('GET', '/organizations/search?q=$query');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/organizations/search',
        queryParameters: {'q': query},
      );
      
      if (response.isSuccess && response.hasData) {
        final organizations = response.data!
            .map((json) => OrganizationModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/organizations/search?q=$query', 200, data: response.data);
        return ApiResponse.success(organizations);
      } else {
        Logger.logApiError('GET', '/organizations/search?q=$query', response.error ?? 'Unknown error');
        return response.transform((_) => <OrganizationModel>[]);
      }
    } catch (e) {
      Logger.error('Search organizations failed', error: e);
      return ApiResponse.error('Search organizations failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<OrganizationMemberModel>> addMember(int organizationId, int userId, String role) async {
    try {
      Logger.logApiRequest('POST', '/organizations/$organizationId/members', data: {'userId': userId, 'role': role});
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/organizations/$organizationId/members',
        data: {'userId': userId, 'role': role},
      );
      
      if (response.isSuccess && response.hasData) {
        final member = OrganizationMemberModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/organizations/$organizationId/members', 201, data: response.data);
        return ApiResponse.success(member);
      } else {
        Logger.logApiError('POST', '/organizations/$organizationId/members', response.error ?? 'Unknown error');
        return response.transform((_) => OrganizationMemberModel());
      }
    } catch (e) {
      Logger.error('Add organization member failed', error: e);
      return ApiResponse.error('Add organization member failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> removeMember(int organizationId, int userId) async {
    try {
      Logger.logApiRequest('DELETE', '/organizations/$organizationId/members/$userId');
      
      final response = await _apiClient.delete<void>('/organizations/$organizationId/members/$userId');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/organizations/$organizationId/members/$userId', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/organizations/$organizationId/members/$userId', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Remove organization member failed', error: e);
      return ApiResponse.error('Remove organization member failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<OrganizationMemberModel>> updateMemberRole(int organizationId, int userId, String role) async {
    try {
      Logger.logApiRequest('PATCH', '/organizations/$organizationId/members/$userId/role', data: {'role': role});
      
      final response = await _apiClient.patch<Map<String, dynamic>>(
        '/organizations/$organizationId/members/$userId/role',
        data: {'role': role},
      );
      
      if (response.isSuccess && response.hasData) {
        final member = OrganizationMemberModel.fromJson(response.data!);
        
        Logger.logApiResponse('PATCH', '/organizations/$organizationId/members/$userId/role', 200, data: response.data);
        return ApiResponse.success(member);
      } else {
        Logger.logApiError('PATCH', '/organizations/$organizationId/members/$userId/role', response.error ?? 'Unknown error');
        return response.transform((_) => OrganizationMemberModel());
      }
    } catch (e) {
      Logger.error('Update organization member role failed', error: e);
      return ApiResponse.error('Update organization member role failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<OrganizationMemberModel>>> getOrganizationMembers(int organizationId) async {
    try {
      Logger.logApiRequest('GET', '/organizations/$organizationId/members');
      
      final response = await _apiClient.get<List<dynamic>>('/organizations/$organizationId/members');
      
      if (response.isSuccess && response.hasData) {
        final members = response.data!
            .map((json) => OrganizationMemberModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/organizations/$organizationId/members', 200, data: response.data);
        return ApiResponse.success(members);
      } else {
        Logger.logApiError('GET', '/organizations/$organizationId/members', response.error ?? 'Unknown error');
        return response.transform((_) => <OrganizationMemberModel>[]);
      }
    } catch (e) {
      Logger.error('Get organization members failed', error: e);
      return ApiResponse.error('Get organization members failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> inviteMember(int organizationId, String email, String role) async {
    try {
      Logger.logApiRequest('POST', '/organizations/$organizationId/invitations', data: {'email': email, 'role': role});
      
      final response = await _apiClient.post<void>(
        '/organizations/$organizationId/invitations',
        data: {'email': email, 'role': role},
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/organizations/$organizationId/invitations', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/organizations/$organizationId/invitations', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Invite member failed', error: e);
      return ApiResponse.error('Invite member failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> acceptInvitation(String invitationToken) async {
    try {
      Logger.logApiRequest('POST', '/organizations/invitations/accept', data: {'token': invitationToken});
      
      final response = await _apiClient.post<void>(
        '/organizations/invitations/accept',
        data: {'token': invitationToken},
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/organizations/invitations/accept', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/organizations/invitations/accept', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Accept invitation failed', error: e);
      return ApiResponse.error('Accept invitation failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> declineInvitation(String invitationToken) async {
    try {
      Logger.logApiRequest('POST', '/organizations/invitations/decline', data: {'token': invitationToken});
      
      final response = await _apiClient.post<void>(
        '/organizations/invitations/decline',
        data: {'token': invitationToken},
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/organizations/invitations/decline', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/organizations/invitations/decline', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Decline invitation failed', error: e);
      return ApiResponse.error('Decline invitation failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<Map<String, dynamic>>> getOrganizationSettings(int organizationId) async {
    try {
      Logger.logApiRequest('GET', '/organizations/$organizationId/settings');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/organizations/$organizationId/settings');
      
      if (response.isSuccess && response.hasData) {
        Logger.logApiResponse('GET', '/organizations/$organizationId/settings', 200, data: response.data);
        return ApiResponse.success(response.data!);
      } else {
        Logger.logApiError('GET', '/organizations/$organizationId/settings', response.error ?? 'Unknown error');
        return response.transform((_) => <String, dynamic>{});
      }
    } catch (e) {
      Logger.error('Get organization settings failed', error: e);
      return ApiResponse.error('Get organization settings failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> updateOrganizationSettings(int organizationId, Map<String, dynamic> settings) async {
    try {
      Logger.logApiRequest('PUT', '/organizations/$organizationId/settings', data: settings);
      
      final response = await _apiClient.put<void>(
        '/organizations/$organizationId/settings',
        data: settings,
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('PUT', '/organizations/$organizationId/settings', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('PUT', '/organizations/$organizationId/settings', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Update organization settings failed', error: e);
      return ApiResponse.error('Update organization settings failed: $e');
    }
  }
}