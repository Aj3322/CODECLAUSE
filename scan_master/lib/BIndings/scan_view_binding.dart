import 'package:get/get.dart';
import 'package:scan_master/controllers/scan_controller.dart';

import '../services/setting_service.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanViewController());
  }

}