import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../models/chat/chat_model.dart';

abstract class ChatRepository {
  Future<ApiResponse<List<ChatModel>>> getAllChats();
  Future<ApiResponse<ChatModel>> getChatById(int id);
  Future<ApiResponse<ChatModel>> createChat(Map<String, dynamic> chatData);
  Future<ApiResponse<void>> deleteChat(int id);
  Future<ApiResponse<List<ChatModel>>> getChatsByType(String type);
  Future<ApiResponse<List<ChatModel>>> searchChats(String query);
  Future<ApiResponse<ChatMessageModel>> sendMessage(int chatId, String content, {String? messageType});
  Future<ApiResponse<List<ChatMessageModel>>> getChatMessages(int chatId);
  Future<ApiResponse<ChatMessageModel>> sendAIMessage(int chatId, String content);
  Future<ApiResponse<void>> markMessageAsRead(int chatId, int messageId);
  Future<ApiResponse<void>> archiveChat(int chatId);
  Future<ApiResponse<void>> unarchiveChat(int chatId);
}

class ChatRepositoryImpl implements ChatRepository {
  final ApiClient _apiClient;
  
  ChatRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;
  
  @override
  Future<ApiResponse<List<ChatModel>>> getAllChats() async {
    try {
      Logger.logApiRequest('GET', '/chats');
      
      final response = await _apiClient.get<List<dynamic>>('/chats');
      
      if (response.isSuccess && response.hasData) {
        final chats = response.data!
            .map((json) => ChatModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/chats', 200, data: response.data);
        return ApiResponse.success(chats);
      } else {
        Logger.logApiError('GET', '/chats', response.error ?? 'Unknown error');
        return response.transform((_) => <ChatModel>[]);
      }
    } catch (e) {
      Logger.error('Get all chats failed', error: e);
      return ApiResponse.error('Get all chats failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ChatModel>> getChatById(int id) async {
    try {
      Logger.logApiRequest('GET', '/chats/$id');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/chats/$id');
      
      if (response.isSuccess && response.hasData) {
        final chat = ChatModel.fromJson(response.data!);
        
        Logger.logApiResponse('GET', '/chats/$id', 200, data: response.data);
        return ApiResponse.success(chat);
      } else {
        Logger.logApiError('GET', '/chats/$id', response.error ?? 'Unknown error');
        return response.transform((_) => ChatModel());
      }
    } catch (e) {
      Logger.error('Get chat by ID failed', error: e);
      return ApiResponse.error('Get chat by ID failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ChatModel>> createChat(Map<String, dynamic> chatData) async {
    try {
      Logger.logApiRequest('POST', '/chats', data: chatData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/chats',
        data: chatData,
      );
      
      if (response.isSuccess && response.hasData) {
        final chat = ChatModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/chats', 201, data: response.data);
        return ApiResponse.success(chat);
      } else {
        Logger.logApiError('POST', '/chats', response.error ?? 'Unknown error');
        return response.transform((_) => ChatModel());
      }
    } catch (e) {
      Logger.error('Create chat failed', error: e);
      return ApiResponse.error('Create chat failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> deleteChat(int id) async {
    try {
      Logger.logApiRequest('DELETE', '/chats/$id');
      
      final response = await _apiClient.delete<void>('/chats/$id');
      
      if (response.isSuccess) {
        Logger.logApiResponse('DELETE', '/chats/$id', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('DELETE', '/chats/$id', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Delete chat failed', error: e);
      return ApiResponse.error('Delete chat failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<ChatModel>>> getChatsByType(String type) async {
    try {
      Logger.logApiRequest('GET', '/chats?type=$type');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/chats',
        queryParameters: {'type': type},
      );
      
      if (response.isSuccess && response.hasData) {
        final chats = response.data!
            .map((json) => ChatModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/chats?type=$type', 200, data: response.data);
        return ApiResponse.success(chats);
      } else {
        Logger.logApiError('GET', '/chats?type=$type', response.error ?? 'Unknown error');
        return response.transform((_) => <ChatModel>[]);
      }
    } catch (e) {
      Logger.error('Get chats by type failed', error: e);
      return ApiResponse.error('Get chats by type failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<ChatModel>>> searchChats(String query) async {
    try {
      Logger.logApiRequest('GET', '/chats/search?q=$query');
      
      final response = await _apiClient.get<List<dynamic>>(
        '/chats/search',
        queryParameters: {'q': query},
      );
      
      if (response.isSuccess && response.hasData) {
        final chats = response.data!
            .map((json) => ChatModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/chats/search?q=$query', 200, data: response.data);
        return ApiResponse.success(chats);
      } else {
        Logger.logApiError('GET', '/chats/search?q=$query', response.error ?? 'Unknown error');
        return response.transform((_) => <ChatModel>[]);
      }
    } catch (e) {
      Logger.error('Search chats failed', error: e);
      return ApiResponse.error('Search chats failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ChatMessageModel>> sendMessage(int chatId, String content, {String? messageType}) async {
    try {
      final messageData = {
        'content': content,
        'messageType': messageType ?? 'text',
        'senderType': 'user',
      };
      
      Logger.logApiRequest('POST', '/chats/$chatId/messages', data: messageData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/chats/$chatId/messages',
        data: messageData,
      );
      
      if (response.isSuccess && response.hasData) {
        final message = ChatMessageModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/chats/$chatId/messages', 201, data: response.data);
        return ApiResponse.success(message);
      } else {
        Logger.logApiError('POST', '/chats/$chatId/messages', response.error ?? 'Unknown error');
        return response.transform((_) => ChatMessageModel());
      }
    } catch (e) {
      Logger.error('Send message failed', error: e);
      return ApiResponse.error('Send message failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<List<ChatMessageModel>>> getChatMessages(int chatId) async {
    try {
      Logger.logApiRequest('GET', '/chats/$chatId/messages');
      
      final response = await _apiClient.get<List<dynamic>>('/chats/$chatId/messages');
      
      if (response.isSuccess && response.hasData) {
        final messages = response.data!
            .map((json) => ChatMessageModel.fromJson(json))
            .toList();
        
        Logger.logApiResponse('GET', '/chats/$chatId/messages', 200, data: response.data);
        return ApiResponse.success(messages);
      } else {
        Logger.logApiError('GET', '/chats/$chatId/messages', response.error ?? 'Unknown error');
        return response.transform((_) => <ChatMessageModel>[]);
      }
    } catch (e) {
      Logger.error('Get chat messages failed', error: e);
      return ApiResponse.error('Get chat messages failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<ChatMessageModel>> sendAIMessage(int chatId, String content) async {
    try {
      final messageData = {
        'content': content,
        'messageType': 'text',
        'senderType': 'ai',
      };
      
      Logger.logApiRequest('POST', '/chats/$chatId/ai-messages', data: messageData);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/chats/$chatId/ai-messages',
        data: messageData,
      );
      
      if (response.isSuccess && response.hasData) {
        final message = ChatMessageModel.fromJson(response.data!);
        
        Logger.logApiResponse('POST', '/chats/$chatId/ai-messages', 201, data: response.data);
        return ApiResponse.success(message);
      } else {
        Logger.logApiError('POST', '/chats/$chatId/ai-messages', response.error ?? 'Unknown error');
        return response.transform((_) => ChatMessageModel());
      }
    } catch (e) {
      Logger.error('Send AI message failed', error: e);
      return ApiResponse.error('Send AI message failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> markMessageAsRead(int chatId, int messageId) async {
    try {
      Logger.logApiRequest('PATCH', '/chats/$chatId/messages/$messageId/read');
      
      final response = await _apiClient.patch<void>('/chats/$chatId/messages/$messageId/read');
      
      if (response.isSuccess) {
        Logger.logApiResponse('PATCH', '/chats/$chatId/messages/$messageId/read', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('PATCH', '/chats/$chatId/messages/$messageId/read', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Mark message as read failed', error: e);
      return ApiResponse.error('Mark message as read failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> archiveChat(int chatId) async {
    try {
      Logger.logApiRequest('PATCH', '/chats/$chatId/archive');
      
      final response = await _apiClient.patch<void>('/chats/$chatId/archive');
      
      if (response.isSuccess) {
        Logger.logApiResponse('PATCH', '/chats/$chatId/archive', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('PATCH', '/chats/$chatId/archive', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Archive chat failed', error: e);
      return ApiResponse.error('Archive chat failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> unarchiveChat(int chatId) async {
    try {
      Logger.logApiRequest('PATCH', '/chats/$chatId/unarchive');
      
      final response = await _apiClient.patch<void>('/chats/$chatId/unarchive');
      
      if (response.isSuccess) {
        Logger.logApiResponse('PATCH', '/chats/$chatId/unarchive', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('PATCH', '/chats/$chatId/unarchive', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Unarchive chat failed', error: e);
      return ApiResponse.error('Unarchive chat failed: $e');
    }
  }
}