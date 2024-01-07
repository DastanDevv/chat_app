import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.senderUid,
  });

  final String sender;
  final String text;
  final String time;
  final String senderUid;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender': sender,
      'text': text,
      'time': time,
      'senderUid': senderUid,
    };
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'] as String,
      text: map['text'] as String,
      time: (map['time'] as Timestamp).toDate().toString(),
      senderUid: map['senderUid'] as String,
    );
  }

  bool isMyMessage(String uid) {
    return senderUid == uid;
  }
}
