import 'dart:developer';

class MessageModel {
  int? msgId;
  String msg_content;
  String msg_date_time;
  String senderid;
  int chat_id;
  String senderName;

  MessageModel({
    this.msgId,
    required this.msg_content,
    required this.msg_date_time,
    required this.senderid,
    required this.chat_id,
    required this.senderName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final senderData = json['sender_data'].toString().split("+");
    log(senderData.toString());
    log(senderData.first);
    log(senderData.last);
    return MessageModel(
      msgId: json['msg_id'],
      msg_content: json['msg_content'],
      msg_date_time: json['msg_date_time'],
      senderid: senderData.first,
      chat_id: json['chat_id'],
      senderName: senderData.last,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //   'msg_id': msgId,
      'msg_content': msg_content,
      'msg_date_time': msg_date_time,
      'sender_data': "$senderid+${senderName ?? ""}",
      'chat_id': chat_id,
    };
  }
}
