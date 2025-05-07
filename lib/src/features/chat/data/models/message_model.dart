class MessageModel {
  int? msgId;
  String msg_content;
  String msg_date_time;
  String senderid;
  int chat_id;

  MessageModel({
    this.msgId,
    required this.msg_content,
    required this.msg_date_time,
    required this.senderid,
    required this.chat_id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msgId: json['msg_id'],
      msg_content: json['msg_content'],
      msg_date_time: json['msg_date_time'],
      senderid: json['sender_data'],
      chat_id: json['chat_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //   'msg_id': msgId,
      'msg_content': msg_content,
      'msg_date_time': msg_date_time,
      'sender_data': senderid,
      'chat_id': chat_id,
    };
  }
}
