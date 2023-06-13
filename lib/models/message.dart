class Message {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  Message(
      {required this.content, required this.isUser, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {'content': content, 'isUser': isUser, 'timestamp': timestamp};
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        content: json['content'],
        isUser: json['isUser'],
        timestamp: DateTime.parse(json['timestamp']));
  }
}
