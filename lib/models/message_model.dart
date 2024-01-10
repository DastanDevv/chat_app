import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  /// Представляет объект сообщения.
  ///
  /// [sender] - Отправитель сообщения.
  /// [text] - Содержание сообщения.
  /// [time] - Время отправки сообщения.
  /// [senderUid] - Уникальный идентификатор отправителя.
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

  /// Преобразует объект  [Message]  в формат JSON.
  ///
  /// Возвращает [Map<String, dynamic>] представление объекта.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender': sender,
      'text': text,
      'time': time,
      'senderUid': senderUid,
    };
  }

  /// Создает объект [Message] из карты JSON.
  ///
  /// [map] -Карта JSON, представляющая объект  [Message].
  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'] as String,
      text: map['text'] as String,
      time: (map['time'] as Timestamp).toDate().toString(),
      senderUid: map['senderUid'] as String,
    );
  }

  /// Проверяет, было ли сообщение отправлено определенным пользователем.
  ///
  /// [uid] - Tуникальный идентификатор пользователя.
  ///
  ///Возвращает `true`, если сообщение было отправлено пользователем, `false` в противном случае.
  bool isMyMessage(String uid) {
    return senderUid == uid;
  }
}
