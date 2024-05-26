import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_reader/routes/app_routes.dart';
import 'package:pdf_reader/services/bookmark_service.dart';
import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<BookmarkService>(() async => BookmarkService()); // Initialize BookmarkService
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PDF Reader',
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.pages,
    );
  }
}
