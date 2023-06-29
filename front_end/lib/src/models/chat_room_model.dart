import 'package:getgoods/src/models/user_model.dart';

class ChatList {
  final String chatId;
  final String userId;
  final String shopId;
  final String userName;
  final String userPhoto;
  final String shopPhoto;

  ChatList({
    required this.chatId,
    required this.userId,
    required this.shopId,
    required this.userName,
    required this.userPhoto,
    required this.shopPhoto,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    List<dynamic> members = json['members'];
    Map<String, dynamic> user = members[0]['user'];
    Map<String, dynamic> shop = members[1]['shop'];

  return ChatList(
    chatId: json['_id'] ?? '',
    userId: user['_id'] ?? '',
    shopId: shop['_id'] ?? '',
    userName: user['name'] ?? '',
    userPhoto: user['photo'] ?? '',
    shopPhoto: shop['photo'] ?? '',
  );
}
}
