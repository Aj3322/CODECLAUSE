import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import '../../../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../theme/color_palette.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getUser();
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      return Scaffold(
        appBar: AppPages.currentIndex.value == 0
            ? AppBar(
          title: const Text('Social Circle'),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () => Get.toNamed(Routes.CHAT),
              icon: const Icon(Icons.chat_bubble),
            )
          ],
        )
            : null,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Obx(() {
                var user = controller.userModel.value;
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: ColorPalette.primaryColor),
                  currentAccountPicture: CircleAvatar(
                    radius: 30,
                    backgroundImage: user?.profilePicUrl != null
                        ? NetworkImage(user!.profilePicUrl)
                        : null,
                    child: user?.profilePicUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  accountName: Text(user?.username ?? 'Loading...'),
                  accountEmail: Text(user?.email ?? 'Loading...'),
                  onDetailsPressed: () => Get.toNamed(Routes.PROFILEUPDATE),
                );
              }),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Messages'),
                onTap: () {
                  Get.toNamed(Routes.CHAT);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Log Out'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offNamed(Routes.LOGIN);
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: Obx(() {
            return IndexedStack(
              index: AppPages.currentIndex.value,
              children: AppPages.bottomNavigationRoutes
                  .map((route) => route.page())
                  .toList(),
            );
          }),
        ),

        bottomNavigationBar: Obx(() {
          var user = controller.userModel.value;
          return BottomNavigationBar(
            backgroundColor: ColorPalette.primaryColor,
            selectedLabelStyle: TextStyle(color:isDarkMode ? Colors.white:null ),
            currentIndex: AppPages.currentIndex.value,
            onTap: (index) => AppPages.currentIndex.value = index,
            items: [
              BottomNavigationBarItem(
                backgroundColor: isDarkMode ? null : ColorPalette.primaryColor,
                icon: const Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: isDarkMode ? null : ColorPalette.primaryColor,
                icon: const Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                backgroundColor: isDarkMode ? null : ColorPalette.primaryColor,
                icon: const Icon(Icons.add),
                label: 'Create Post',
              ),
              BottomNavigationBarItem(
                backgroundColor: isDarkMode ? null : ColorPalette.primaryColor,
                icon: user?.profilePicUrl != null
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(user!.profilePicUrl),
                  radius: 18,
                )
                    : const Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          );
        }),
      );
    });
  }
}
