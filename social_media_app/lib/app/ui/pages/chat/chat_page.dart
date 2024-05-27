import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/message_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/pages/profile/search_profile.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import '../../../controllers/chat_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/Date_time_formate.dart';
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
            Get.bottomSheet(NewMessageDialog(),  isScrollControlled: true,
              useRootNavigator: true,ignoreSafeArea: false);
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
        return StreamBuilder<UserModel>(
          stream: ServiceLocator.userRepository.userStream(FirebaseAuth.instance.currentUser!.uid),
          builder: (context,snap) {
            if (snap.connectionState == ConnectionState.waiting||snap.data==null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder<List<UserModel>>(
              stream: controller.getAllChatUser(snap.data!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting||snapshot.data==null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.data!.isEmpty){
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
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel user = snapshot.data![index];
                    if (user.uid == FirebaseAuth.instance.currentUser!.uid) return const Divider(height: 0);
                    return Container(
                      padding: const EdgeInsets.all(10).copyWith(top: 0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () => Get.toNamed(Routes.CHATSCREEN,arguments: user),
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                colors: ColorPalette.linearColor,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                            user.isOnline ? 'Online' : MyDateUtil().getLastActiveTime(context: context, lastActive: user.lastActiveAt.toLocal().toString()),
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            );
          }
        );
      }),
    );
  }
}

class NewMessageDialog extends StatefulWidget {
  @override
  _NewMessageDialogState createState() => _NewMessageDialogState();
}

class _NewMessageDialogState extends State<NewMessageDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Message"),
        actions: [
          IconButton(onPressed: (){setState(() {
            isSearch=!isSearch;
          });},iconSize: 30,
              icon: Icon(Icons.search_sharp))
        ],
      ),
      body: Column(
        children: [
          isSearch?
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: 'Search Users',
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5)),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ):Container(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorPalette.linearColor,
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').snapshots().map((doc) {
                  return doc.docs
                      .map((doc) => UserModel.fromMap(doc.data())).toList();}),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final users = snapshot.data!;
                  final filteredUsers = users.where((user) {
                    final username = user.username.toLowerCase();
                    return username.contains(_searchText);
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user = filteredUsers[index];
                      print(index);
                      return filteredUsers[index].uid == FirebaseAuth.instance.currentUser!.uid
                          ? const SizedBox.shrink()
                          : Container(
                        margin: const EdgeInsets.all(10).copyWith(top:index==1?10:0),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: ColorPalette.linearColor,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: ListTile(
                          onTap: () => Get.to(() => SearchProfileScreen(userModel: user)),
                          leading: Container(
                            decoration: BoxDecoration(
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
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            user.bio,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: IconButton.filledTonal(
                            color: ColorPalette.cardColor,
                            iconSize: 25,
                            onPressed: () {
                              Get.back(
                              );
                              Get.toNamed(Routes.CHATSCREEN, arguments: user);
                            },
                            icon: const Icon(Icons.chat_outlined),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
