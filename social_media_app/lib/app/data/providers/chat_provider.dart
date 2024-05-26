import '../models/message_model.dart';
import 'package:flutter/material.dart';
import 'local_provider.dart';
class ChatProvider with ChangeNotifier {
  final LocalProvider _localProvider;

  ChatProvider(this._localProvider);

  List<String> _chatIds = [];
  List<String> get chatIds => _chatIds;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;

  Future<void> loadChats(String userId) async {
    _chatIds = _localProvider.getChatsForUser(userId);
    notifyListeners();
  }

  Future<void> loadMessagesForUser(String userId) async {
    _messages = _localProvider.getMessagesForUser(userId);
    notifyListeners();
  }

  Future<void> loadMessagesForGroup(String groupId) async {
    _messages = _localProvider.getMessagesForGroup(groupId);
    notifyListeners();
  }


}
