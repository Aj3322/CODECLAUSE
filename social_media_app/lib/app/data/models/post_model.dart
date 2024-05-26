import 'package:hive/hive.dart';

import '../enum/enum.dart';
part 'post_model.g.dart';
@HiveType(typeId: 2)
class Post {
  @HiveField(0)
  String postId;
  @HiveField(1)
  String uid;
  @HiveField(2)
  String username;
  @HiveField(3)
  String profilePicUrl;
  @HiveField(4)
  List<String> content; // List to hold multiple pages of content (image URLs or text)
  @HiveField(5)
  String caption;
  @HiveField(6)
  List<String> likes;
  @HiveField(7)
  List<String> comments;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  String? location;
  @HiveField(10)
  List<String>? tags;
  @HiveField(11)
  int postTypeIndex;
  @HiveField(12)
  String privacy;


  Post({
    required this.postId,
    required this.uid,
    required this.username,
    required this.profilePicUrl,
    required this.content,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.createdAt,
    this.location,
    this.tags,
    required this.postTypeIndex,
    required this.privacy,
  });

  // Method to convert PostModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'uid': uid,
      'username': username,
      'profilePicUrl': profilePicUrl,
      'content': content,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'location': location,
      'tags': tags,
      'postType': postType.index, // Store enum as integer
      'privacy': privacy,
    };
  }

  // Method to create PostModel from a map (Firestore document snapshot)
  factory Post.fromMap(Map<String, dynamic> map) {
    print("Post Type 8888888888888888888888    data ${map['postType']}");
    return Post(
      postId: map['postId'],
      uid: map['uid'],
      username: map['username'],
      profilePicUrl: map['profilePicUrl'],
      content: List<String>.from(map['content'])??[],
      caption: map['caption']??'',
      likes: List<String>.from(map['likes'])??[],
      comments: List<String>.from(map['comments'])??[],
      createdAt: DateTime.parse(map['createdAt']),
      location: map['location'],
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
      postTypeIndex: map['postType']??0,
      privacy: map['privacy'],
    );
  }

  // Getter for post type
  PostType get postType {
    return PostType.values[postTypeIndex];
  }
}
