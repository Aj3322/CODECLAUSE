import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/controllers/profile_controller.dart';
import 'package:social_media_app/app/data/models/post_model.dart';
import 'package:social_media_app/app/data/repositories/post_repository.dart';

import '../data/models/user_model.dart' as a ;
import '../services/database_service.dart';

class HomeController extends GetxController {
  var userModel = Rx<a.UserModel?>(null);
  RxList<Post> posts = <Post>[].obs;

  Future<void> getUser() async {
    userModel.value = await ServiceLocator.userRepository.getUser();
    print(userModel.value!.email);
  }
  PostRepository postRepository = ServiceLocator.postRepository;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUser();
  }
}
