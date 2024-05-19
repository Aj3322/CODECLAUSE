import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_master/BIndings/scan_view_binding.dart';
import 'package:scan_master/services/setting_service.dart';
import 'routes.dart';
import 'services/storage_service.dart';
import 'views/scan_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await SettingsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsService settingsService = Get.find<SettingsService>();
    settingsService.setSystemDarkMode(context);
    return Obx(()=>GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: settingsService.darkMode.value
            ? ThemeData.dark()
            : ThemeData.light(),
        initialRoute: '/',
        initialBinding: HomeViewBinding(),
        getPages: AppRoutes.routes,
        home:const ScanView()
    )
    );
  }
}





