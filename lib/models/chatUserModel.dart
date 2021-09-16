class ChatUserModel {
  String? roomid;
  String? roomname;
  List<dynamic>? users;
  List<dynamic>? meesages;
  ChatUserModel({
    this.roomid,
    this.roomname,
    this.users,
    this.meesages,
  });
  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      roomid: json["_id"],
      meesages: json["Messages"],
      roomname: json["roomName"],
      users: json["users"],
    );
  }
}

class MessageModel {
  final String? senderId;
  final String? message;
  final String? senderName;

  MessageModel({this.message, this.senderId, this.senderName});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json["message"],
      senderId: json["senderId"],
      senderName: json["sender"],
    );
  }
}
