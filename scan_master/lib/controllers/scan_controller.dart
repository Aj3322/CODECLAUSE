import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light/light.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_utils/qr_code_utils.dart';
import 'package:flutter/material.dart';
import 'package:scan_master/services/setting_service.dart';
import '../models/scan_model.dart';
import '../services/storage_service.dart';

class ScanViewController extends GetxController {
  RxString scannedData = ''.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  RxBool isCameraPaused = false.obs;
  var flashState = 'off'.obs;
  var flash = true.obs;

  Light? _light;
  late StreamSubscription _subscription;

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      qrController?.resumeCamera();
    } else {
      Get.snackbar("Permission Denied", "Camera permission is required to scan QR codes.");
    }
  }

  void onQRViewCreated(QRViewController qrController) {
    final SettingsService settingsService = Get.find();
    this.qrController = qrController;
    qrController.scanInvert(settingsService.invertScan.value);
    qrController.scannedDataStream.listen((scanData) {
      scannedData.value = scanData.code ?? '';
      if (scannedData.value.isNotEmpty) {
        final newScan = ScanModel(
          data: scannedData.value,
          dateTime: DateTime.now(),
        );
        StorageService.scanBox.add(newScan);
        qrController.pauseCamera(); // Pause after first scan
        Get.snackbar("Scanned", "Data: ${scannedData.value}");
        Get.defaultDialog(
          title: 'Result',
          content: Text(newScan.data),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        );
      }
    });
  }
  void toggleFlash() {

    if (flashState.value == 'off') {
      qrController?.toggleFlash();
      flashState.value = 'on';
    } else if (flashState.value == 'on') {
      qrController?.toggleFlash();
      flashState.value = 'auto';
      flash.value=true;
    } else if (flashState.value == 'auto') {
      var c = qrController?.getFlashStatus();

        qrController?.toggleFlash();
        flashState.value = 'off';
      qrController?.toggleFlash();

    }
  }

  void toggleCamera() {
    if (isCameraPaused.value) {
      qrController?.resumeCamera();
    } else {
      qrController?.pauseCamera();
    }
    isCameraPaused.value = !isCameraPaused.value;
    isCameraPaused.refresh();
  }

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
         scannedData.value = (await scanImage(pickedFile.path))!;
        if (scannedData.isNotEmpty) {
          final newScan = ScanModel(
            data: scannedData.value,
            dateTime: DateTime.now(),
          );
          StorageService.scanBox.add(newScan);
          Get.defaultDialog(
            title: 'Result',
            content: Text(newScan.data),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          );
        } else {
          Get.defaultDialog(
            title: 'Not Found',
            content: const Text('No QR code or barcode found in the picked image.'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error scanning image: $e');
        }
        Get.snackbar("Error", "An error occurred while scanning the image");
      }
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
    }
  }

  Future<String?> scanImage(String imagePath) async {
    try {
      String data = await QrCodeUtils.decodeFrom(imagePath) ?? 'Unknown platform version';
      if (kDebugMode) {
        print(data);
      }
      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error scanning image: $e');
      }
      return null;
    }
  }
  void onLightData(int luxValue) {
    if (flashState.value == 'auto'&&qrController?.getFlashStatus()==false){
      if (luxValue < 50) {
        qrController?.toggleFlash();
      }
    }
  }
  @override
  void onInit() {
    requestCameraPermission();
    _light = Light();
    _subscription = _light!.lightSensorStream.listen(onLightData);
    super.onInit();
  }

  @override
  void onClose() {
    qrController?.stopCamera();
    qrController?.dispose();
    super.onClose();
  }
}
