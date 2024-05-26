import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
import '../../../controllers/home_controller.dart';
import '../../widgets/post_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: ServiceLocator.postRepository.postStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            if (controller.posts.isNotEmpty) {
              return ListView.builder(
                // itemCount: controller.posts.length,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  child: PostCard(
                    post: snapshot.data![index],
                  ),
                ),
              );
            } else {
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
                      child: SvgPicture.asset("assets/world_is_mine.svg")),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh,
                        color: ColorPalette.primaryColor,
                      ),
                      label: const Text(
                        "Refresh",
                        style: TextStyle(color: ColorPalette.primaryColor),
                      )),
                ],
              );
            }
            return Center(
              child: Column(
                children: [
                  const Text('Nothing to show'),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('Refresh'),
                    icon: const Icon(Icons.refresh),
                  )
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => Container(
                child:
                    // index == 0
                    //     ? Container(
                    //         height: 80,
                    //         child: ListView.builder(
                    //           itemCount: snapshot.data!.length,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) => CircleAvatar(
                    //             backgroundImage: NetworkImage(
                    //                 snapshot.data![index].profilePicUrl),
                    //             radius: 45,
                    //           ),
                    //         ),
                    //       )
                    //     :
                    Card(
              elevation: 4,
              child: PostCard(
                post: snapshot.data![index == 0 ? index : index],
              ),
            )),
          );
        },
      ),
    );
  }
}
