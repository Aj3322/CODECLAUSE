import 'package:hive/hive.dart';
part 'notfication_model.g.dart';

@HiveType(typeId: 3)
class NotificationModel {
  @HiveField(0)
  String notificationId;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  bool seen;

  @HiveField(5)
  String type;

  @HiveField(6)
  String? postId;

  @HiveField(7)
  String senderId;

  @HiveField(8)
  String? postContent;

  @HiveField(9)
  String? postType;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.content,
    required this.timestamp,
    required this.seen,
    required this.type,
    this.postId,
    required this.senderId,
    this.postContent,
    this.postType,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'userId': userId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'seen': seen,
      'type': type,
      'postId': postId,
      'senderId': senderId,
      'postContent': postContent,
      'postType': postType,
    };
  }

  // Create NotificationModel from a map
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationId: map['notificationId'],
      userId: map['userId'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
      seen: map['seen'],
      type: map['type'],
      postId: map['postId'],
      senderId: map['senderId'],
      postContent: map['postContent'],
      postType: map['postType'],
    );
  }
}
