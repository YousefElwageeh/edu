class ChatModel {
  int chatId;
  String chatName;
  String? lastMessage;
  DateTime? lastmessageTime;

  ChatModel(
      {required this.chatId,
      required this.chatName,
      this.lastMessage,
      this.lastmessageTime});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chat_id'],
      chatName: json['chat_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'chat_name': chatName,
    };
  }
}
