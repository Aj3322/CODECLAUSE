import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/data/models/post_model.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../../routes/app_pages.dart';
import '../pages/comments/comments_page.dart';
import 'Like_animation.dart';

class PostCard extends GetView {
  final Post post;
  PostCard({Key? key, required this.post}) : super(key: key);

  bool isLikeAnimating = false;
  final TextEditingController commentEditingController =
      TextEditingController();

  deletePost(String postId) async {}

  void postComment(String uid, String name, String profilePic) async {}

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: isDarkMode?null:LinearGradient(colors: ColorPalette.linearColor)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(post.profilePicUrl.isEmpty
                      ? 'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611716.jpg'
                      : post.profilePicUrl),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          DateFormat.yMMMd().format(post.createdAt),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: isDarkMode?null:Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                post.uid == ServiceLocator.userRepository.userModel!.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shrinkWrap: true,
                                      children: ['Delete']
                                          .map(
                                            (e) => InkWell(
                                              onTap: () {
                                                ServiceLocator.postRepository
                                                    .deletePost(post.postId);
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ));
                        },
                        icon: const Icon(
                          Icons.more_horiz_outlined,
                          color: Color(0xFFD4BEC1),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: PostC(
                  post: post,
                  width: width,
                  isLikeAnimating: isLikeAnimating,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60,
                      top: 4,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 12,
                            color: Colors.red,
                          ),
                          Text(
                            '@${post.username}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                    ),
                    child: Row(
                      children: [
                        LikeAnimation(
                          isAnimating: post.likes.contains(''),
                          smallLike: true,
                          child: IconButton(
                            onPressed: () async {ServiceLocator.postRepository.likePost(post);},
                            icon: post.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline_rounded,
                                    color: ColorPalette.textColor,
                                  ),
                          ),
                        ),
                        Text(
                          '${post.likes.length}',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => Get.toNamed(Routes.COMMENTS,
                              arguments: post.postId),
                          icon: const Icon(
                            Icons.comment_outlined,
                            color: ColorPalette.textColor,
                          ),
                        ),
                        Text(
                          '${post.comments.length}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 10),
                    child: Stack(
                      children: [
                        TextField(
                          controller: commentEditingController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xFFC9C9C9),
                            hintText: 'Comments',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            filled: true,
                            contentPadding:
                                const EdgeInsets.all(8).copyWith(left: 20),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              if (commentEditingController.text.isNotEmpty) {
                                UserModel user =
                                    ServiceLocator.userRepository.userModel!;
                                ServiceLocator.commentRepository.addComment(
                                    CommentModel(
                                        commentId: Uuid().v4(),
                                        postId: post.postId,
                                        userId: user.uid,
                                        username: user.username,
                                        userAvatarUrl: user.profilePicUrl,
                                        content: commentEditingController.text,
                                        timestamp: DateTime.timestamp(),
                                        likes: 0,
                                        replies: [],
                                        isEdited: false,
                                        isDeleted: false));

                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   padding: const EdgeInsets.symmetric(vertical:12 ,horizontal:16 ),
                  // child: Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     DefaultTextStyle(style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800), child: const Text('1024 likes'),),
                  //     Container(
                  //       width: double.infinity,
                  //       padding: const EdgeInsets.only(top: 4),
                  //       child: RichText(
                  //         text: const TextSpan(
                  //           style: TextStyle(color: primaryColor),
                  //           children: [
                  //             TextSpan(
                  //               style: TextStyle(fontWeight: FontWeight.bold,),
                  //               text: 'username'
                  //             ),
                  //             TextSpan(
                  //                 text: 'Hey some description to be replaced'
                  //             ),
                  //           ]
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),

                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostC extends StatefulWidget {
  final Post post;
  final double width;
  final bool isLikeAnimating;

  const PostC({
    Key? key,
    required this.post,
    required this.width,
    required this.isLikeAnimating,
  }) : super(key: key);

  @override
  _PostCState createState() => _PostCState();
}

class _PostCState extends State<PostC> {
  late VideoPlayerController _controller;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    // if (widget.post.postType == PostType.video) {
    //   _controller = VideoPlayerController.network(widget.post.content.first)
    //     ..initialize().then((_) {
    //       setState(() {});
    //       _controller.setLooping(true);
    //       _controller.play();
    //       _controller.setVolume(0);
    //     }).catchError((error) {
    //       print('Video player error: $error');
    //     });
    // }
  }

  @override
  void dispose() {
    if (widget.post.postType == PostType.video) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onDoubleTap: () async {

          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: widget.post.postType == PostType.video
                      ? h * 0.55
                      : h * 0.4,
                ),
                width: widget.post.postType == PostType.video
                    ? widget.width * 0.65
                    : widget.width * 0.75,
                child: widget.post.postType == PostType.text
                    ? Container(
                        color: ColorPalette.primaryColor,
                        child: Center(child: Text(widget.post.content.first)),
                      )
                    : widget.post.postType == PostType.image
                        ? Image.network(
                            widget.post.content.first,
                            fit: BoxFit.cover,
                          )
                        : _controller.value.isInitialized
                            ? Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        _isMuted
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isMuted = !_isMuted;
                                          _controller
                                              .setVolume(_isMuted ? 0 : 1);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Center(child: CircularProgressIndicator()),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: widget.isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: widget.isLikeAnimating,
                  duration: const Duration(milliseconds: 200),
                  onEnd: () {},
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 120,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
