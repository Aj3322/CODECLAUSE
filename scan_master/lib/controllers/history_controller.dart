import 'package:get/get.dart';
import '../models/scan_model.dart';
import '../services/storage_service.dart';

class HistoryController extends GetxController {
  var scanHistory = <ScanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    scanHistory.addAll(StorageService.scanBox.values);
  }
}
