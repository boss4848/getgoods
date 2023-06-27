import 'package:getgoods/src/models/user_model.dart';

class ChatList {
  final String chatId;
  final List<UserDetail> member;

  ChatList({
    required this.chatId,
    required this.member,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      chatId: json['_id'] ?? '',
      member: List<UserDetail>.from(json['members']),
    );
  }
}
