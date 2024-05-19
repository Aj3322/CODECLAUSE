import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/setting_service.dart';
class SettingsView extends GetView<SettingsService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: controller.darkMode.value,
              onChanged: (value) => controller.toggleDarkMode(value),
            ),
            SwitchListTile(
              title: const Text('Auto Detect'),
              value: controller.autoDetect.value,
              onChanged: (value) => controller.toggleAutoDetect(value),
            ),
            SwitchListTile(
              title: const Text('Touch To Focus'),
              value: controller.touchFocus.value,
              onChanged: (value) => controller.toggleTouchFocus(value),
            ),
            SwitchListTile(
              title: const Text('Inverted Scan'),
              value: controller.invertScan.value,
              onChanged: (value) => controller.toggleInvertScan(value),
            ),
            SwitchListTile(
              title: const Text('Focus Enabled'),
              value: controller.focusEnabled.value,
              onChanged: (value) => controller.toggleFocus(value),
            ),
          ],
        );
      }),
    );
  }
}
