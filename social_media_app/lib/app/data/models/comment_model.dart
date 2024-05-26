class CommentModel {
  String commentId;
  String postId;
  String userId;
  String username;
  String userAvatarUrl;
  String content;
  DateTime timestamp;
  int likes;
  List<CommentModel> replies;
  bool isEdited;
  bool isDeleted;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.username,
    required this.userAvatarUrl,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.replies,
    required this.isEdited,
    required this.isDeleted,
  });

  // Method to convert CommentModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'userId': userId,
      'username': username,
      'userAvatarUrl': userAvatarUrl,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'replies': replies.map((reply) => reply.toMap()).toList(),
      'isEdited': isEdited,
      'isDeleted': isDeleted,
    };
  }

  // Method to create CommentModel from a map (Firestore document snapshot)
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'],
      postId: map['postId'],
      userId: map['userId'],
      username: map['username'],
      userAvatarUrl: map['userAvatarUrl'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
      likes: map['likes'],
      replies: (map['replies'] as List<dynamic>).map((reply) => CommentModel.fromMap(reply)).toList(),
      isEdited: map['isEdited'],
      isDeleted: map['isDeleted'],
    );
  }
}
