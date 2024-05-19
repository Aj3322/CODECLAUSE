import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  final RxBool focusEnabled = false.obs;
  final RxBool touchFocus = true.obs;
  final RxBool autoDetect = true.obs;
  final RxBool darkMode = false.obs;
  final RxBool invertScan = false.obs;
  final RxBool systemDarkMode = false.obs;

  late SharedPreferences _prefs;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    Get.put(SettingsService(prefs));
  }

  SettingsService(this._prefs) {
    loadSettings();
  }

  void loadSettings() {
    focusEnabled.value = _prefs.getBool('focusEnabled') ?? false;
    touchFocus.value = _prefs.getBool('touchFocus') ?? true;
    autoDetect.value = _prefs.getBool('autoDetect') ?? true;
    darkMode.value = _prefs.getBool('darkMode') ?? false;
    invertScan.value = _prefs.getBool('invertScan') ?? false;
  }

  void saveSettings() {
    _prefs.setBool('focusEnabled', focusEnabled.value);
    _prefs.setBool('touchFocus', touchFocus.value);
    _prefs.setBool('autoDetect', autoDetect.value);
    _prefs.setBool('darkMode', darkMode.value);
    _prefs.setBool('invertScan', invertScan.value);
  }

  void toggleFocus(bool value) {
    focusEnabled.value = value;
    saveSettings();
  }

  void toggleTouchFocus(bool value) {
    touchFocus.value = value;
    saveSettings();
  }

  void toggleInvertScan(bool value) {
    invertScan.value = value;
    saveSettings();
  }

  void toggleAutoDetect(bool value) {
    autoDetect.value = value;
    saveSettings();
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    saveSettings();
  }

  void setSystemDarkMode(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    darkMode.value = brightness == Brightness.dark;
    systemDarkMode.value = brightness == Brightness.dark;
  }
}

