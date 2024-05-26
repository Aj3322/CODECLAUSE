// lib/bindings/initial_binding.dart

import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/recent_controller.dart';
import '../controllers/bookmark_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/pdf_view_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}