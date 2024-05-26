import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';

import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class SearchPageController extends GetxController {
  var searchTextController = TextEditingController();
  var searchResults = <UserModel>[].obs;
  var isLoading = false.obs;
  var topUsers = <UserModel>[].obs;

  final UserRepository userRepository = ServiceLocator.userRepository;

  void searchUsers(String query) async {
    isLoading.value = true;
    try {
      if (query.isEmpty) {
        topUsers.value = await userRepository.fetchTopUsers();
        searchResults.clear();
      } else {
        searchResults.value = await userRepository.searchUsersByUsernameOrEmail(query);
        if (searchResults.isEmpty) {
          topUsers.value = await userRepository.fetchTopUsers();
        } else {
          topUsers.clear();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search users: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
