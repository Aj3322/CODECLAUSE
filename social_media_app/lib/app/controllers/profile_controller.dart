import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';

import '../data/models/user_model.dart';

class ProfileController extends GetxController {
  // Implement your logic here
  var postData = ''.obs;
  var postLen = 0.obs;
  var followers = 0.obs;
  var following = 0.obs;
  var isFollowing = false.obs;
  var isLoading = false.obs;
  var uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }
  Rx<UserModel> userModel = ServiceLocator.userRepository.userModel!.obs;
  void getData() async {
    isLoading.value = true;
    try {
      uid.value = userModel.value.uid;
      isFollowing.value = userModel.value.followers.contains(userModel.value.uid);
    } catch (e) {
     Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }
}
