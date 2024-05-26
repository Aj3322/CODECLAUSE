import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/controllers/comments_controller.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/comment_widget.dart';

class CommentsPage extends GetView<CommentsController> {
  CommentsPage({
    Key? key,
  }) : super(key: key);
  final postId = Get.arguments;
  final TextEditingController commentEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Comments',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: controller.getComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: '',
                    contentPadding: const EdgeInsets.all(20),
                    content: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Unfollow account"),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.person_remove_alt_1_outlined))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Delete"),
                            IconButton(
                                onPressed: () {
                                  controller.commentRepository.deleteComment(
                                      snapshot.data![index].commentId,
                                      snapshot.data![index].postId);
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      ],
                    ));
              },
              child: CommentCard(
                commentModel: snapshot.data![index],
              ),
            ),
          );
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            Obx(() => CircleAvatar(
                  radius: 18,
                  backgroundImage:
                      NetworkImage(controller.userModel.value.profilePicUrl),
                )),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: commentEditingController,
                      decoration: InputDecoration(
                        hintText: 'Write a Comments',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: ColorPalette.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: ColorPalette.primaryColor,
                            )),
                        // filled: true,
                        contentPadding: const EdgeInsets.all(8)
                            .copyWith(left: 20, right: 40),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(
                        onPressed: () {
                          String commentId = const Uuid().v4();
                          UserModel userModel = controller.userModel.value;
                          controller.postComment(CommentModel(
                              commentId: commentId,
                              postId: postId,
                              userId: userModel.uid,
                              username: userModel.username,
                              userAvatarUrl: userModel.profilePicUrl,
                              content: commentEditingController.text,
                              timestamp: DateTime.now(),
                              likes: 0,
                              replies: [],
                              isEdited: false,
                              isDeleted: false));
                        },
                        icon: const Icon(
                          Icons.send,
                          color: ColorPalette.primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          ),
    );
  }
}
