
import 'package:get/get.dart';
import '../screens/home/home_screen.dart';
import '../screens/recent/recent_screen.dart';
import '../screens/bookmark/bookmark_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/pdf_view/pdf_view_screen.dart';
import '../bindings/home_binding.dart';
import '../bindings/recent_binding.dart';
import '../bindings/bookmark_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/pdf_view_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.RECENT,
      page: () => RecentScreen(),
      binding: RecentBinding(),
    ),
    GetPage(
      name: AppRoutes.BOOKMARK,
      page: () => BookmarkScreen(),
      binding: BookmarkBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.PDF_VIEW,
      page: () => PdfViewScreen(),
      binding: PdfViewBinding(),
    ),
  ];
}


