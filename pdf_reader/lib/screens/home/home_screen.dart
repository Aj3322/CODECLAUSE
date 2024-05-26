
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: controller.fetchPdfFiles, child: Text("Click")),
          Obx(() {
            if (controller.pdfList.isEmpty) {
              return Center(child: Text('No PDFs found'));
            }
            return ListView.builder(
              itemCount: controller.pdfList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.pdfList[index].name),
                  onTap: () {
                    // Open PDF
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
