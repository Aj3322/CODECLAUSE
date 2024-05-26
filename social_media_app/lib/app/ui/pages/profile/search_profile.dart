import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/data/enum/enum.dart';
import 'package:social_media_app/app/data/repositories/user_repository.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/pages/home/home_page.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../theme/color_palette.dart';
import '../../widgets/Following_button.dart';
import '../../widgets/profile_post.dart';

class SearchProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const SearchProfileScreen({Key? key, required this.userModel})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SearchProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    print(widget.userModel.profilePicUrl);
  }

  UserRepository userRepository = ServiceLocator.userRepository;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: widget.userModel.profilePicUrl.isEmpty
                      ? Container()
                      : Image.network(
                          widget.userModel.profilePicUrl,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12).copyWith(top: 35),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(50)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 2,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          border: Border.all(
                              color: ColorPalette.textColor, width: 3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.47,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40)
                                        .copyWith(top: 10),
                                child: Text(
                                  widget.userModel.username,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50)
                                        .copyWith(top: 10),
                                child: const Divider(
                                  color: Colors.white,
                                  height: 4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  buildStatColumn(
                                                      widget.userModel.followers
                                                          .length,
                                                      "Followers"),
                                                  buildStatColumn(
                                                      widget.userModel.posts
                                                          .length,
                                                      "Posts"),
                                                  buildStatColumn(
                                                      widget.userModel.following
                                                          .length,
                                                      "Following"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('posts')
                                    .where('uid',
                                        isEqualTo: widget.userModel.uid)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  List<Post> posts = snapshot.data!.docs
                                      .map((doc) => Post.fromMap(doc.data()))
                                      .toList();
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: 75,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: posts.length,
                                      itemBuilder: (context, index) {
                                        final post = posts[index];
                                        return InkWell(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ProfilePost(
                                                posts: posts,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox(
                                                width: 80,
                                                child: post.postType ==
                                                        PostType.text
                                                    ? Text(post.content.first)
                                                    : Image(
                                                        image: NetworkImage(
                                                            posts[index]
                                                                .content
                                                                .first),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.userModel.uid
                                      ? FollowButton(
                                          text: 'Log Out',
                                          backgroundColor: Colors.black,
                                          textColor: ColorPalette.primaryColor,
                                          borderColor: Colors.grey,
                                          function: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Get.offNamed(Routes.LOGIN);
                                          },
                                        )
                                      : widget.userModel.followers.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? FollowButton(
                                              text: 'Unfollow',
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.grey,
                                              function: () async {},
                                            )
                                          : FollowButton(
                                              text: 'Follow',
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              borderColor: Colors.blue,
                                              function: () async {},
                                            )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
