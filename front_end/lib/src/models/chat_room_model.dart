import 'package:getgoods/src/models/user_model.dart';

class ChatList {
  final String chatId;
  final List<User> member;

  ChatList({
    required this.chatId,
    required this.member,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      chatId: json['_id'] ?? '',
      member: (json['members'] as List)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
