import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/search_controller.dart';
import 'package:social_media_app/app/data/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/controllers/search_controller.dart';
import 'package:social_media_app/app/data/models/user_model.dart';

import '../profile/search_profile.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Users',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.searchTextController,
              decoration: InputDecoration(
                hintText: 'Search by username or email...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    controller.searchUsers(controller.searchTextController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                controller.searchUsers(value);
              },
              onChanged: (value){
                controller.searchUsers(value);
              },
            ),
            const SizedBox(height: 20),
            Obx(
                  () {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty && controller.topUsers.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchResults.isNotEmpty
                        ? controller.searchResults.length
                        : controller.topUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user = controller.searchResults.isNotEmpty
                          ? controller.searchResults[index]
                          : controller.topUsers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePicUrl),
                        ),
                        title: Text(user.username),
                        subtitle: Text(user.email),
                        onTap: () {
                           Get.to(SearchProfileScreen(userModel: user,));
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


