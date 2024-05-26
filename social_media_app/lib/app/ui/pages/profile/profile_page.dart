import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/widgets/post_widget.dart';
import '../../../controllers/profile_controller.dart';
class MyProfile extends GetView<ProfileController> {
  const MyProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.userModel.value.username),
      ),
      body: Obx(
            () =>controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
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
                padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 10),
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(controller.userModel.value.followers.length, "Followers"),
                                  buildStatColumn(controller.userModel.value.posts.length, "Posts"),
                                  buildStatColumn(controller.userModel.value.following.length, "Following"),
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
              StreamBuilder(
                stream:ServiceLocator.postRepository.postStreamByUserId(controller.userModel.value.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }else if(!snapshot.hasData){
                    return Container();
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return snapshot.hasData?InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostCard(
                                post: snapshot.data![index]
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: 80,
                                child: Image(
                                  image: NetworkImage(snapshot.data![index].content.first),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ):Container();
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
