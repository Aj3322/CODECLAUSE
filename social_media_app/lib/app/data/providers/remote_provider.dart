import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import '../models/comment_model.dart';
import '../models/notfication_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';

class RemoteProvider {
  RemoteProvider._privateConstructor();

  static final RemoteProvider _instance = RemoteProvider._privateConstructor();

  factory RemoteProvider() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User methods
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print("======================");
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUser(String id) async {
    final doc = await _firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<List<UserModel>> searchUsersByUsernameOrEmail(String query) async {
    final usersByUsernameSnapshot = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query.capitalizeFirst)
        .where('username', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    final usersByEmailSnapshot = await _firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query.capitalizeFirst)
        .where('email', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    final userIdsFromPosts = await _firestore
        .collection('posts')
        .where('tags', arrayContains: query.capitalizeFirst)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc['uid']).toSet());

    // Check if userIdsFromPosts is empty
    if (userIdsFromPosts.isNotEmpty) {
      final usersFromPostsSnapshot = await _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIdsFromPosts.toList())
          .get();

      final users = [
        ...usersByUsernameSnapshot.docs,
        ...usersByEmailSnapshot.docs,
        ...usersFromPostsSnapshot.docs
      ].map((doc) => UserModel.fromMap(doc.data())).toSet().toList();
      return users;
    }

    final users = [
      ...usersByUsernameSnapshot.docs,
      ...usersByEmailSnapshot.docs,
    ].map((doc) => UserModel.fromMap(doc.data())).toSet().toList();

    return users;
  }

  Future<List<UserModel>> fetchTopUsers() async {
    final snapshot = await _firestore
        .collection('users')
        .orderBy('followersCount', descending: true)
        .limit(10)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  Stream<UserModel> userStream(String id) {
    return _firestore.collection('users').doc(id).snapshots().map((doc) {
      return UserModel.fromMap(doc.data()!);
    });
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await _firestore
        .collection('users')
        .doc(updatedUser.uid)
        .update(updatedUser.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // Post methods
  Future<void> savePost(Post post) async {
    await _firestore.collection('posts').doc(post.postId).set(post.toMap());
  }

  Stream<List<Post>> getPosts() {
    return _firestore
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((query) {
      return query.docs.map((doc) => Post.fromMap(doc.data())).toList();
    });
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Future<void> likePost(Post post) async {
    UserModel userModel = ServiceLocator.userRepository.userModel!;
    final postRef = _firestore.collection('posts').doc(post.postId);
    final postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      List<dynamic> likes = postSnapshot.data()!['likes'] ?? [];

      if (likes.contains(userModel.uid)) {
        // Unlike the post
        await postRef.update({
          'likes': FieldValue.arrayRemove([userModel.uid])
        });
      } else {
        // Like the post
        await postRef.update({
          'likes': FieldValue.arrayUnion([userModel.uid])
        });
      }
    }
  }



  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.postId).set(post.toMap());
  }

  // Chat methods

  // One-to-One Chat
  Future<void> sendMessageToOneToOneChat(
      String chatId, MessageModel message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<MessageModel>> getMessagesFromOneToOneChat(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages').orderBy('timestamp', descending: true)
        .snapshots()
        .map((query) {
      return query.docs.map((doc) => MessageModel.fromMap(doc.data())).toList();
    });
  }

  // Group Chat
  Future<void> createGroupChat(Map<String, dynamic> chatData) async {
    await _firestore.collection('group_chats').add(chatData);
  }

  Future<void> sendMessageToGroupChat(
      String chatId, MessageModel message) async {
    await _firestore
        .collection('group_chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<MessageModel>> getMessagesFromGroupChat(String chatId) {
    return _firestore
        .collection('group_chats')
        .doc(chatId)
        .collection('messages')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) => MessageModel.fromMap(doc.data())).toList();
    });
  }

  // Notification methods
  Future<void> sendNotification(NotificationModel notification) async {
    await _firestore
        .collection('notifications')
        .doc(notification.notificationId)
        .set(notification.toMap());
  }

  Stream<List<NotificationModel>> getNotificationsForUser(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((query) {
      return query.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    });
  }

  Future<void> updateNotification(NotificationModel updatedNotification) async {
    await _firestore
        .collection('notifications')
        .doc(updatedNotification.notificationId)
        .update(updatedNotification.toMap());
  }

  Future<void> deleteNotification(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).delete();
  }

  // Comment methods
  Future<void> addComment(CommentModel comment) async {
    await _firestore
        .collection('comments')
        .doc(comment.commentId)
        .set(comment.toMap());
    // Add comment ID to the respective post
    await _firestore.collection('posts').doc(comment.postId).update({
      'comments': FieldValue.arrayUnion([comment.commentId])
    });
  }

  Stream<List<CommentModel>> getCommentsForPost(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((query) {
      return query.docs.map((doc) => CommentModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> updateComment(CommentModel updatedComment) async {
    await _firestore
        .collection('comments')
        .doc(updatedComment.commentId)
        .update(updatedComment.toMap());
  }

  Future<void> deleteComment(String commentId,String postId) async {
    await _firestore.collection('comments').doc(commentId).delete();

    await _firestore.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayRemove([commentId])
    });

  }

  Stream<List<UserModel>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> replyToComment(String commentId, CommentModel reply) async {
    final replyRef = _firestore.collection('comments').doc(commentId).collection('replies').doc(reply.commentId);
    await replyRef.set(reply.toMap());
  }

  Future<void> likeComment(String commentId, String userId) async {
    final commentRef = _firestore.collection('comments').doc(commentId);
    await commentRef.update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> likeReply(String commentId, String replyId, String userId) async {
    final replyRef = _firestore.collection('comments').doc(commentId).collection('replies').doc(replyId);
    await replyRef.update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  Stream<List<Post>> getPostsStream() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
    });
  }

  Stream<List<NotificationModel>> getNotificationsStreamForUser(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    });
  }

  Stream<List<MessageModel>> getMessagesStreamForUser(String userId) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      List<MessageModel> messages = [];
      for (final doc in snapshot.docs) {
        final messagesQuery = await doc.reference.collection('messages').get();
        messages.addAll(messagesQuery.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
      }
      return messages;
    });
  }

  Stream<List<Post>> getPostsByUserId(String userId) {
    return _firestore.collection('posts').where('uid', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
    });
  }

  Stream<List<UserModel>> getAllChatUser(){
    return _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: ServiceLocator.userRepository.userModel!.chatUserIds).snapshots().map((event) => event.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
  }
}
