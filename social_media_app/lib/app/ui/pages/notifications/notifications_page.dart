import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/notifications_controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications Page'),
      ),
    );
  }
}
