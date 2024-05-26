// lib/app/ui/pages/post_create/post_create_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../controllers/post_create_controller.dart';
import '../../../data/enum/enum.dart';

class PostCreatePage extends GetView<PostCreateController> {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Obx(
                () => TextButton(
              onPressed: controller.isLoading.value ? null : controller.uploadPost,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : const Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.captionController,
              decoration: const InputDecoration(
                hintText: 'Write a caption...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              maxLines: 3,
              onChanged: (value) {
                controller.captionController.text = value;
              },
            ),
            SizedBox(height: 20),
            Obx(
                  () {
                if (controller.selectedFiles.isEmpty) {
                  return GestureDetector(
                    onTap: () => controller.selectFiles(context),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Tap to select images or video',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      for (var file in controller.selectedFiles)
                        if (controller.postType.value == PostType.image)
                          Image.file(
                            File(file.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        else
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.videocam,
                                color: Colors.grey[600],
                                size: 100,
                              ),
                            ),
                          ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: controller.clearSelectedFiles,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
