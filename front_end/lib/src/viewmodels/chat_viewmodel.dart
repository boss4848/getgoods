import 'package:dio/dio.dart';
import 'package:getgoods/src/models/chat_message_model.dart';
import 'package:getgoods/src/models/chat_room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../services/api_service.dart';

enum ChatState {
  loading,
  success,
  error,
}

class ChatViewModel {
  final Dio _dio = Dio();
  ChatState state = ChatState.loading;
  List<ChatMessage> message = [];
  List<ChatList> chatList = [];

  Future<void> fetchChatMessage(String chatId) async {
    final String getChatsUrl = '${ApiConstants.baseUrl}/chats/$chatId';

    state = ChatState.loading;
    try {
      final response = await Dio().get(getChatsUrl);
      final data = response.data['data']['chats'];

      message = List<ChatMessage>.from(data.map((chat) {
        return ChatMessage.fromJson(chat);
      }));
      state = ChatState.success;
    } catch (e) {
      print('Error fetching chat list: $e');
      state = ChatState.error;
    }
  }

  Future<void> fetchChatList() async {
    state = ChatState.loading;

    try {
      final response = await ApiService.request(
        'GET',
        '${ApiConstants.baseUrl}/chats/chatList',
        requiresAuth: true,
      );
      
      final data = response.data['data']['chats'];

      chatList = List<ChatList>.from(data.map((chat) {
        return ChatList.fromJson(chat);
      }));
      state = ChatState.success;
    } catch (e) {
      print('Error fetching chat list: $e');
      state = ChatState.error;
    }
  }
}
