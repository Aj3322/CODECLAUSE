import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/pages/home/home_view.dart';
import 'package:social_media_app/app/ui/widgets/post_widget.dart';
import '../../../controllers/profile_controller.dart';
import '../../../data/models/post_model.dart';
import '../../theme/color_palette.dart';

class MyProfile extends GetView<ProfileController> {
  const MyProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.userModel.value.username),
        titleSpacing: 30,
      ),

      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? null
                : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: ColorPalette.linearColor,
            ),
          ),
                padding: const EdgeInsets.only(top: 35),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          controller.userModel.value.profilePicUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40)
                          .copyWith(top: 10),
                      child: Text(
                        controller.userModel.value.username,
                        style: const TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
                                   Obx(() =>  Row(
                                     mainAxisSize: MainAxisSize.max,
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceEvenly,
                                     children: [
                                       buildStatColumn(
                                           controller.userModel.value.followers
                                               .length,
                                           "Followers"),
                                       buildStatColumn(
                                           controller
                                               .userModel.value.posts.length,
                                           "Posts"),
                                       buildStatColumn(
                                           controller.userModel.value.following
                                               .length,
                                           "Following"),
                                     ],
                                   ),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    StreamBuilder(
                      stream: ServiceLocator.postRepository
                          .postStreamByUserId(controller.userModel.value.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (!snapshot.hasData) {
                          return Container();
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 75,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(ProfilePostView(
                                            snapshot.data!, index));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: SizedBox(
                                            width: 80,
                                            child: Image(
                                              image: NetworkImage(snapshot
                                                  .data![index].content.first),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
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
              // color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePostView extends StatefulWidget {
  final List<Post> posts;
  final int scrollIndex;
  const ProfilePostView(this.posts, this.scrollIndex, {super.key});

  @override
  _ProfilePostViewState createState() => _ProfilePostViewState();
}

class _ProfilePostViewState extends State<ProfilePostView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex();
    });
  }

  void _scrollToIndex() {
    if (_scrollController.hasClients) {
      final double position = widget.scrollIndex * 100.0; // Adjust this value based on your item height
      _scrollController.jumpTo(position);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) => Card(
          elevation: 4,
          child: PostCard(
            post: widget.posts[index],
          ),
        ),
      ),
    );
  }
}