class ChatMessage {
  final String message;
  final String sender;
  final String chatId;
  final DateTime createdAt;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.chatId,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'],
      chatId: json['chatId'],
      sender: json['sender'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'chatId': chatId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
