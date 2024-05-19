import 'package:get/get.dart';
import 'package:scan_master/views/scan_view.dart';
import 'views/history_view.dart';
import 'views/settings_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const ScanView()),
    GetPage(name: '/history', page: () => HistoryView()),
    GetPage(name: '/settings', page: () => SettingsView()),
  ];
}
