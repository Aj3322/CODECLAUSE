// Firestore instance
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/user_model.dart';

import '../models/message_model.dart';
import '../providers/local_provider.dart';
import '../providers/remote_provider.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Send a new message
Future<void> sendMessage(MessageModel message) async {
  await _firestore.collection('messages').doc(message.messageId).set(message.toMap());
}

// Get a message by Message ID
Future<MessageModel?> getMessage(String messageId) async {
  DocumentSnapshot doc = await _firestore.collection('messages').doc(messageId).get();
  if (doc.exists) {
    return MessageModel.fromMap(doc.data() as Map<String, dynamic>);
  }
  return null;
}

// Update a message (e.g., to mark it as read or delivered)
Future<void> updateMessage(MessageModel message) async {
  await _firestore.collection('messages').doc(message.messageId).update(message.toMap());
}


class ChatRepository {
  ChatRepository._privateConstructor();

  static final ChatRepository _instance = ChatRepository._privateConstructor();

  factory ChatRepository() {
    return _instance;
  }


  final LocalProvider _localProvider = LocalProvider();
  final RemoteProvider _remoteProvider = RemoteProvider();

  // Helper method to generate a unique chat ID
  String _generateChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0 ? '${userId1}_$userId2' : '${userId2}_$userId1';
  }

  Future<void> sendMassage(MessageModel message) async {
    final chatId = _generateChatId(message.senderId, message.receiverId);
    await _remoteProvider.sendMessageToOneToOneChat(chatId, message);
  }

  Future<void> deleteMessage(MessageModel messageModel) async {

  }

  Future<void> updateMessage(MessageModel post) async {

  }


  Stream<List<MessageModel>> getMessage(UserModel user) {
    final chatId = _generateChatId(FirebaseAuth.instance.currentUser!.uid, user.uid);
    return _remoteProvider.getMessagesFromOneToOneChat(chatId);
  }

  Future<void> syncMessage() async {
  }

  Stream<List<UserModel>> getAllChatUser() {
    return _remoteProvider.getAllChatUser();
  }
}
