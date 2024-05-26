import os

# Define the project structure
project_structure = {
    "lib": {
        "assets": {
            "images": {},
            "fonts": {}
        },
        "bindings": {
            "home_binding.dart": "",
            "recent_binding.dart": "",
            "bookmark_binding.dart": "",
            "settings_binding.dart": "",
            "pdf_view_binding.dart": ""
        },
        "controllers": {
            "home_controller.dart": "",
            "recent_controller.dart": "",
            "bookmark_controller.dart": "",
            "settings_controller.dart": "",
            "pdf_view_controller.dart": ""
        },
        "models": {
            "pdf_file.dart": "",
            "bookmark.dart": ""
        },
        "routes": {
            "app_pages.dart": "",
            "app_routes.dart": ""
        },
        "screens": {
            "home": {
                "home_screen.dart": "",
                "home_view.dart": "",
                "home_controller.dart": ""
            },
            "recent": {
                "recent_screen.dart": "",
                "recent_view.dart": "",
                "recent_controller.dart": ""
            },
            "bookmark": {
                "bookmark_screen.dart": "",
                "bookmark_view.dart": "",
                "bookmark_controller.dart": ""
            },
            "settings": {
                "settings_screen.dart": "",
                "settings_view.dart": "",
                "settings_controller.dart": ""
            },
            "pdf_view": {
                "pdf_view_screen.dart": "",
                "pdf_view.dart": "",
                "pdf_view_controller.dart": ""
            }
        },
        "services": {
            "pdf_service.dart": "",
            "bookmark_service.dart": "",
            "settings_service.dart": ""
        },
        "utils": {
            "constants.dart": "",
            "helpers.dart": ""
        },
        "widgets": {
            "pdf_list_tile.dart": "",
            "bookmark_tile.dart": "",
            "custom_app_bar.dart": "",
            "search_bar.dart": ""
        },
        "main.dart": ""
    }
}

# Create the directories and files
def create_structure(base_path, structure):
    for name, content in structure.items():
        path = os.path.join(base_path, name)
        if isinstance(content, dict):
            os.makedirs(path, exist_ok=True)
            create_structure(path, content)
        else:
            with open(path, 'w') as file:
                file.write(content)

# Define initial content for some files
main_dart_content = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'bindings/initial_binding.dart';

void main() {
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
"""

app_pages_content = """
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
"""

home_controller_content = """
import 'package:get/get.dart';
import '../models/pdf_file.dart';
import '../services/pdf_service.dart';

class HomeController extends GetxController {
  var pdfList = <PdfFile>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPdfFiles();
  }

  void fetchPdfFiles() async {
    var pdfs = await PdfService().getAllPdfs();
    pdfList.assignAll(pdfs);
  }
}
"""

home_screen_content = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Obx(() {
        if (controller.pdfList.isEmpty) {
          return Center(child: Text('No PDFs found'));
        }
        return ListView.builder(
          itemCount: controller.pdfList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.pdfList[index].title),
              onTap: () {
                // Open PDF
              },
            );
          },
        );
      }),
    );
  }
}
"""

# Insert initial content into the structure
project_structure['lib']['main.dart'] = main_dart_content
project_structure['lib']['routes']['app_pages.dart'] = app_pages_content
project_structure['lib']['controllers']['home_controller.dart'] = home_controller_content
project_structure['lib']['screens']['home']['home_screen.dart'] = home_screen_content

# Run the script
if __name__ == "__main__":
    base_path = "./"
    create_structure(base_path, project_structure)
