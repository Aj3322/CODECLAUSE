import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String profilePicUrl;

  @HiveField(4)
  String bio;

  @HiveField(5)
  List<String> followers;

  @HiveField(6)
  List<String> following;

  @HiveField(7)
  List<String> posts;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime lastActiveAt;

  @HiveField(10)
  bool isVerified;

  @HiveField(11)
  String? contactNumber;

  @HiveField(12)
  String? location;

  @HiveField(13)
  String? website;

  @HiveField(14)
  Map<String, dynamic>? preferences;

  @HiveField(15)
  String? notificationToken;

  @HiveField(16)
  bool isOnline;

  @HiveField(17)
  String? accountType;

  @HiveField(18)
  DateTime? birthdate;

  @HiveField(19)
  String? gender;

  @HiveField(20)
  String? status;

  @HiveField(21)
  List<String>? chatUserIds;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.posts,
    required this.createdAt,
    required this.lastActiveAt,
    required this.isVerified,
    this.contactNumber,
    this.location,
    this.website,
    this.preferences,
    this.notificationToken,
    this.isOnline = false,
    this.accountType,
    this.birthdate,
    this.gender,
    this.status,
    this.chatUserIds,
  });

  // Method to convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
      'posts': posts,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt.toIso8601String(),
      'isVerified': isVerified,
      'contactNumber': contactNumber,
      'location': location,
      'website': website,
      'preferences': preferences,
      'notificationToken': notificationToken,
      'isOnline': isOnline,
      'accountType': accountType,
      'birthdate': birthdate?.toIso8601String(),
      'gender': gender,
      'status': status,
      'chatUserIds': chatUserIds,
    };
  }

  // Method to create UserModel from a map (Firestore document snapshot)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      posts: List<String>.from(map['posts'] ?? []),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      lastActiveAt: map['lastActiveAt'] != null ? DateTime.parse(map['lastActiveAt']) : DateTime.now(),
      isVerified: map['isVerified'] ?? false,
      contactNumber: map['contactNumber'],
      location: map['location'],
      website: map['website'],
      preferences: map['preferences'] != null ? Map<String, dynamic>.from(map['preferences']) : null,
      notificationToken: map['notificationToken'],
      isOnline: map['isOnline'] ?? false,
      accountType: map['accountType'],
      birthdate: map['birthdate'] != null ? DateTime.parse(map['birthdate']) : null,
      gender: map['gender'],
      status: map['status'],
      chatUserIds: map['chatUserIds'] != null ? List<String>.from(map['chatUserIds']) : [],
    );
  }

  // Method to create a copy of UserModel with updated fields
  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? profilePicUrl,
    String? bio,
    List<String>? followers,
    List<String>? following,
    List<String>? posts,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    bool? isVerified,
    String? contactNumber,
    String? location,
    String? website,
    Map<String, dynamic>? preferences,
    String? notificationToken,
    bool? isOnline,
    String? accountType,
    DateTime? birthdate,
    String? gender,
    String? status,
    List<String>? chatUserIds,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isVerified: isVerified ?? this.isVerified,
      contactNumber: contactNumber ?? this.contactNumber,
      location: location ?? this.location,
      website: website ?? this.website,
      preferences: preferences ?? this.preferences,
      notificationToken: notificationToken ?? this.notificationToken,
      isOnline: isOnline ?? this.isOnline,
      accountType: accountType ?? this.accountType,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      chatUserIds: chatUserIds ?? this.chatUserIds,
    );
  }
}
