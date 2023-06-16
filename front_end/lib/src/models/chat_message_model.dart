class ChatMessage {
  final String message;
  final String sender;
  final String receiver;
  final String timestamp;
  final String messageType;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.timestamp,
    required this.messageType,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
      timestamp: json['timestamp'],
      messageType: json['messageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp,
      'messageType': messageType,
    };
  }
}
