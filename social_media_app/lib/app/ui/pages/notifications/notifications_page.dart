import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/services/database_service.dart';
import 'package:intl/intl.dart';
import '../../../controllers/notifications_controller.dart';
import '../../../data/models/notfication_model.dart';
import '../../../data/models/user_model.dart';
import '../../theme/color_palette.dart';
import '../profile/search_profile.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notifications = [];
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Function to group notifications
    Map<String, List<NotificationModel>> groupNotifications(List<NotificationModel> notifications) {
      final now = DateTime.now();
      final today = DateFormat('yyyy-MM-dd').format(now);
      final yesterday = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)));

      Map<String, List<NotificationModel>> groupedNotifications = {
        'Today': [],
        'Yesterday': [],
        'This Week': [],
        'This Month': [],
      };

      for (var notification in notifications) {
        final notificationDate = DateFormat('yyyy-MM-dd').format(notification.timestamp);
        if (notificationDate == today) {
          groupedNotifications['Today']!.add(notification);
        } else if (notificationDate == yesterday) {
          groupedNotifications['Yesterday']!.add(notification);
        } else if (now.difference(notification.timestamp).inDays < 7) {
          groupedNotifications['This Week']!.add(notification);
        } else {
          groupedNotifications['This Month']!.add(notification);
        }
      }

      return groupedNotifications;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? null
                    : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorPalette.linearColor,
                ),
              ),
              child: StreamBuilder(
                stream: ServiceLocator.notificationRepository
                    .getNotificationsForUser(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  notifications = snapshot.data!;

                  // Sort notifications by timestamp
                  notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
                  // Group notifications by date
                  final groupedNotifications = groupNotifications(notifications);

                  return ListView(
                    children: [
                      if (groupedNotifications['Today']!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Today', style: Theme.of(context).textTheme.headline6),
                        ),
                        ...groupedNotifications['Today']!.map((notification) => NotificationTile(notification: notification, isDarkMode: isDarkMode, controller: controller)).toList(),
                      ],
                      if (groupedNotifications['Yesterday']!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Yesterday', style: Theme.of(context).textTheme.headline6),
                        ),
                        ...groupedNotifications['Yesterday']!.map((notification) => NotificationTile(notification: notification, isDarkMode: isDarkMode, controller: controller)).toList(),
                      ],
                      if (groupedNotifications['This Week']!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('This Week', style: Theme.of(context).textTheme.headline6),
                        ),
                        ...groupedNotifications['This Week']!.map((notification) => NotificationTile(notification: notification, isDarkMode: isDarkMode, controller: controller)).toList(),
                      ],
                      if (groupedNotifications['This Month']!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('This Month', style: Theme.of(context).textTheme.headline6),
                        ),
                        ...groupedNotifications['This Month']!.map((notification) => NotificationTile(notification: notification, isDarkMode: isDarkMode, controller: controller)).toList(),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final bool isDarkMode;
  final NotificationsController controller;

  const NotificationTile({
    Key? key,
    required this.notification,
    required this.isDarkMode,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: controller.getUserDataById(notification.senderId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!userSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        UserModel user = userSnapshot.data!;

        return user.uid == FirebaseAuth.instance.currentUser!.uid
            ? Container()
            : Container(
          margin: const EdgeInsets.all(10).copyWith(top: 10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: isDarkMode
                ? null
                : LinearGradient(
              colors: ColorPalette.linearColor,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            color: isDarkMode ? Colors.black26 : null,
          ),
          child: ListTile(
            onTap: () => Get.to(() => SearchProfileScreen(userModel: user)),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  colors: ColorPalette.linearColor,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(user.profilePicUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            title: Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            subtitle: Text(
              notification.content,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            trailing: notification.type == 'following'
                ? ElevatedButton(
              onPressed: () {},
              child: const Text("Follow"),
            )
                : Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              clipBehavior: Clip.hardEdge,
              child: notification.postType == "image"
                  ? Image.network(
                notification.postContent!,
                fit: BoxFit.fill,
              )
                  : notification.postType == "text"
                  ? Text(notification.postContent!)
                  : Container(),
            ),
          ),
        );
      },
    );
  }
}
