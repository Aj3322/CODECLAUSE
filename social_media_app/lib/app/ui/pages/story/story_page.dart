import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/story_controller.dart';

class StoryPage extends GetView<StoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story'),
      ),
      body: Center(
        child: Text('Story Page'),
      ),
    );
  }
}
