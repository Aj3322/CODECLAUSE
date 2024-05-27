import 'package:get/get.dart';
import 'package:social_media_app/app/data/models/user_model.dart';
import 'package:social_media_app/app/data/repositories/user_repository.dart';

import '../services/database_service.dart';

class NotificationsController extends GetxController {

  UserRepository userRepository = ServiceLocator.userRepository;


  getUserDataById(userId) {
    return userRepository.getUser(id: userId);
  }
}
