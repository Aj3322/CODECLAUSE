import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/message_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/data/repositories/message_repository.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  var messagesList = <MessageModel>[].obs;
  var showEmoji = false.obs;
  var isUploading = false.obs;
  final textController = TextEditingController();
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  ChatRepository chatRepository = ServiceLocator.chatRepository;
  UserModel userModel = ServiceLocator.userRepository.userModel!;

  @override
  void onInit() {
    super.onInit();
  }

  Stream<List<MessageModel>>getAllMessages(UserModel userModel){
    return chatRepository.getMessage(userModel);
  }
  Stream<List<UserModel>>getAllChatUser(UserModel user){
    return chatRepository.getAllChatUser(user.chatUserIds??[]);
  }

  void sendMessage(UserModel receiverUser , MessageType contentType ,bool isFirstMessage) {
    List<String> content = [];

    if (contentType == MessageType.image) {

    } else if (contentType == MessageType.video) {

    } else if (contentType == MessageType.file) {

    } else if (contentType == MessageType.text) {
      if (textController.text.isNotEmpty) {
        content = [textController.text];
        MessageModel message = MessageModel(messageId: const Uuid().v4(),
            senderId: userModel.uid,
            receiverId: receiverUser.uid,
            senderUsername: userModel.username,
            content: content,
            contentTypes: [contentType],
            timestamp: DateTime.now(),
            isRead: false,
            isDelivered: false
        );
        if(isFirstMessage) {

          chatRepository.sendMassage(message);
          ServiceLocator.userRepository.addUserToChat(message.receiverId,message.senderId);
        }else{
          chatRepository.sendMassage(message);
        }
        textController.clear();
      }
    }
  }

  Future<void> pickImage(ImageSource source,String pathToUpload) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source, imageQuality: 70);
    if (image != null) {
      log('Image Path: ${image.path}');
      isUploading(true);
      // return  ServiceLocator.storageRepository.uploadFile(File(image.path), pathToUpload, 'image');
      isUploading(false);
    }
  }


}
