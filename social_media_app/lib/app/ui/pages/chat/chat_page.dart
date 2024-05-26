import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/message_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/ui/pages/profile/search_profile.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import '../../../controllers/chat_controller.dart';
import '../../../utils/Date_time_formate.dart';
import 'Conversation_page.dart';
class ChatPage extends GetView<ChatController>{
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          // style: TextStyle(color: ColorPalette.headerColor),
        ),
        elevation: 0,
        // backgroundColor: ColorPalette.mobileBackgroundColor,
        leadingWidth: 20,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            // color: ColorPalette.primaryColor,
            size: 35,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          backgroundColor: ColorPalette.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          onPressed: () {
            _showBottomSheetImage(context);
          },
          child: const Icon(
            Icons.add,
            size: 38,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(controller.users.isEmpty){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nothing to Show",
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 200,
                  child: SvgPicture.asset("assets/chat.svg")),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: ColorPalette.primaryColor,
                  ),
                  label: const Text(
                    "Sent a message",
                    style: TextStyle(color: ColorPalette.primaryColor),
                  )),
            ],
          );
        }

        return StreamBuilder<List<UserModel>>(
          stream: controller.getAllChatUser(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                UserModel user = controller.users[index];
                if (user.uid == FirebaseAuth.instance.currentUser!.uid) return const Divider(height: 0);
                return InkWell(
                  onTap: () {
                    Get.to(() => ChatScreenDetail(user: user));
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.yellow, Colors.orange, Colors.redAccent],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Image.network(user.profilePicUrl, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        title: Text(
                          user.username,
                          style: const TextStyle(color: ColorPalette.headerColor, fontWeight: FontWeight.bold),
                        ),
                        subtitle: StreamBuilder(
                          stream: controller.getAllMessages(user),
                          builder: (context, snapshot) {
                            MessageModel? message;
                            bool msg = false;
                            final list = snapshot.data?? [];
                            if (list.isNotEmpty) {
                              message = list[0];
                              if (message.isRead) {
                                msg = true;
                              }
                            }
                            return Text(
                              message != null
                                  ? message.contentTypes.first == MessageType.image
                                  ? 'image'
                                  : message.content.first
                                  : 'Last Message',
                              style: const TextStyle(color: ColorPalette.primaryColor, fontSize: 16),
                              maxLines: 1,
                            );
                          },
                        ),
                        trailing: Text(
                          user.isOnline ? 'Online' : MyDateUtil.getLastActiveTime(context: context, lastActive: user.lastActiveAt.toLocal().toString()),
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: const Divider(height: 4, color: ColorPalette.textColor),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        );
      }),
    );
  }

  void _showBottomSheetImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (_) {
        return _bodyDialog();
      },
    );
  }

  Widget _bodyDialog() {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:ColorPalette.linearColor,
        ),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
             UserModel user = UserModel.fromMap((snapshot.data! as dynamic).docs[index].data());
              return
                (snapshot.data! as dynamic).docs[index]['uid'] == FirebaseAuth.instance.currentUser!.uid
                  ? const Text('') :
              InkWell(
                onTap: () {
                  Get.to(() => SearchProfileScreen(userModel: user,));
                },
                child: Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      colors: ColorPalette.linearColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                              colors: ColorPalette.linearColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.network(user.profilePicUrl, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        title: Text(
                          user.username,
                          style: const TextStyle(color: ColorPalette.headerColor, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          user.bio,
                          style: const TextStyle(color: ColorPalette.primaryColor, fontWeight: FontWeight.w400),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(() => ChatScreenDetail(user: user));
                          },
                          icon: const Icon(Icons.message_rounded, color: ColorPalette.headerColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: const Divider(height: 4, color: ColorPalette.textColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
