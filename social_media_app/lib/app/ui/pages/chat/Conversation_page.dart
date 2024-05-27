import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/message_model.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import '../../../controllers/chat_controller.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/Massage_card.dart';

class ChatScreenDetail extends GetView<ChatController> {
  ChatScreenDetail({super.key});
  UserModel user=Get.arguments;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    RxString v = ''.obs;
    List<MessageModel> message =[];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.black,
        title: Text(
          user.username,
          style: const TextStyle(
            // color: ColorPalette.headerColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              // color: ColorPalette.headerColor,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).pop()),
        leadingWidth: 20,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: controller.getAllMessages(user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                   // message=snapshot.data!;
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Say Hii! 👋',
                          style: TextStyle(
                              fontSize: 20, color: ColorPalette.primaryColor)),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessageCard(
                        message: snapshot.data![index],
                        photoUrl: user.profilePicUrl,
                      );
                    },
                  );
                }
              ),
          ),
          Obx(() {
            return controller.isUploading.value
                ? const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: CircularProgressIndicator(strokeWidth: 2)))
                : const SizedBox.shrink();
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Card(
                    color: ColorPalette.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    // color: ColorPalette.textColor,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.showEmoji.toggle();
                            },
                            icon: const Icon(Icons.emoji_emotions,
                                color: Colors.amberAccent, size: 25)),
                        Expanded(
                            child: TextField(
                          controller: controller.textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Type Something...',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5)),
                          onChanged: (value) {
                            v.value = value;
                          },
                        )),
                        Obx(() => v.value.isEmpty
                            ? IconButton(
                                onPressed: () =>
                                    _showBottomSheetImage(controller, context),
                                icon: const Icon(Icons.image,
                                    // color: ColorPalette.primaryColor,
                                    size: 26))
                            : Container()),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorPalette.primaryColor),
                  child: IconButton(
                      onPressed: () => controller.sendMessage(user,MessageType.text,message.isEmpty?true:false),
                      icon: const Icon(Icons.send, size: 26)),
                ),
              ],
            ),
          ),
          Obx(() {
            return controller.showEmoji.value
                ? SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: controller.textController,
                    ),
                  )
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }

  void _showBottomSheetImage(ChatController controller, BuildContext context) {
    var mq = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: ColorPalette.mobileBackgroundColor,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding:
              EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
          children: [
            const Text('Pick A Image ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: mq.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () => controller.pickImage(ImageSource.gallery,'chat/${user.uid}/image'),
                    child: Image.asset('assets/image/img_1.png')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () => controller.pickImage(ImageSource.camera,'chat/${user.uid}/image'),
                    child: Image.asset('assets/image/img.png')),
              ],
            )
          ],
        );
      },
    );
  }
}
