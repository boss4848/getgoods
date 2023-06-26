class ChatMessage {
  final String message;
  final String sender;
  final String chatId;
  final String timestamp;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.chatId,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'],
      sender: json['sender'],
      chatId: json['chatId'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'chatId': chatId,
      'timestamp': timestamp,
    };
  }
}
