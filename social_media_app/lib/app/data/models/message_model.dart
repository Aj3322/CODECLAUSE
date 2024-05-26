import 'package:hive/hive.dart';

import '../enum/enum.dart';
part 'message_model.g.dart';
@HiveType(typeId: 4)
class MessageModel {
  @HiveField(0)
  String messageId;

  @HiveField(1)
  String senderId;

  @HiveField(2)
  String receiverId;

  @HiveField(3)
  String? groupId;

  @HiveField(4)
  String senderUsername;

  @HiveField(5)
  String? receiverUsername;

  @HiveField(6)
  List<String> content;

  @HiveField(7)
  List<MessageType> contentTypes;

  @HiveField(8)
  DateTime timestamp;

  @HiveField(9)
  bool isRead;

  @HiveField(10)
  bool isDelivered;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    this.groupId,
    required this.senderUsername,
    this.receiverUsername,
    required this.content,
    required this.contentTypes,
    required this.timestamp,
    required this.isRead,
    required this.isDelivered,
  });
  // Method to convert MessageModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderUsername': senderUsername,
      'receiverUsername': receiverUsername,
      'content': content,
      'contentTypes': contentTypes.map((type) => type.index).toList(),
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'isDelivered': isDelivered,
    };
  }

  // Method to create MessageModel from a map (Firestore document snapshot)
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      senderUsername: map['senderUsername'],
      receiverUsername: map['receiverUsername'],
      content: List<String>.from(map['content']),
      contentTypes: (map['contentTypes'] as List<dynamic>).map((index) => MessageType.values[index]).toList(),
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'],
      isDelivered: map['isDelivered'],
    );
  }
}
