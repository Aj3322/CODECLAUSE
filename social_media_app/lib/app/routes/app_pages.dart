import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/ui/pages/chat/Conversation_page.dart';
import 'package:social_media_app/app/ui/pages/home/home_view.dart';
import 'package:social_media_app/app/ui/pages/profile/profile_update.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/search/search_page.dart';
import '../ui/pages/post_create/post_create_page.dart';
import '../ui/pages/settings/settings_page.dart';
import '../ui/pages/profile/profile_page.dart';
import '../ui/pages/chat/chat_page.dart';
import '../ui/pages/comments/comments_page.dart';
import '../ui/pages/story/story_page.dart';
import '../ui/pages/notifications/notifications_page.dart';
import '../ui/pages/auth/login_page.dart';
import '../ui/pages/auth/signup_page.dart';
import '../bindings/home_binding.dart';
import '../bindings/search_binding.dart';
import '../bindings/post_create_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/chat_binding.dart';
import '../bindings/comments_binding.dart';
import '../bindings/story_binding.dart';
import '../bindings/notifications_binding.dart';
import '../bindings/auth_binding.dart';

part 'app_routes.dart';

class AppPages {
  static String INITIAL = FirebaseAuth.instance.currentUser?.uid==null ? Routes.LOGIN: Routes.HOME;
  static RxInt currentIndex = 0.obs;

  static List<GetPage> get bottomNavigationRoutes => [
    GetPage(
      name: Routes.HOMEVIEW,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.POST_CREATE,
      page: () =>PostCreatePage(),
      binding: PostCreateBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => MyProfile(),
      binding: ProfileBinding(),
    ),
  ];

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
      children: bottomNavigationRoutes,
      bindings: [SearchBinding(),SearchBinding(),PostCreateBinding(),ProfileBinding(),]
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHATSCREEN,
      page: () => ChatScreenDetail(),
    ),
    GetPage(
      name: Routes.COMMENTS,
      page: () => CommentsPage(),
      binding: CommentsBinding(),
      fullscreenDialog: true,

    ),
    GetPage(
      name: Routes.STORY,
      page: () => StoryPage(),
      binding: StoryBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.PROFILEUPDATE,
      page: () => ProfileUpdatePage(),
      // binding: AuthBinding(),
    ),
  ];
}
