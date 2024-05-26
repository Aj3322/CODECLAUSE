import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light/light.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_utils/qr_code_utils.dart';
import 'package:flutter/material.dart';
import 'package:scan_master/services/setting_service.dart';
import 'package:url_launcher/url_launcher.dart';
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
        showResultDialog(newScan.data);
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
          showResultDialog(newScan.data);
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

  void showResultDialog( String text) {
    String type = checkStringType(text);

        Get.defaultDialog(
          title: 'Detected Type: $type',
          content: Text('Content: $text'),
          actions: <Widget>[
            if (type == 'URL') ...[
              TextButton(
                child: Text('Open URL'),
                onPressed: () async {
                    await launch(text);
                },
              ),
            ] else if (type == 'Email') ...[
              TextButton(
                child: Text('Send Email'),
                onPressed: () {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: text,
                  );
                  launch(emailUri.toString());
                 Get.back();
                },
              ),
            ] else if (type == 'Phone Number') ...[
              TextButton(
                child: Text('Call'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Get.back();
                },
              ),
            ] else if (type == 'SMS') ...[
              TextButton(
                child: Text('Send Sms'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'SMSTO',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Get.back();
                },
              ),
            ] else if (type == 'vCard') ...[
              TextButton(
                child: const Text('Save Contact'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'data:text/vcard;charset=utf-8,',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Get.back();
                },
              ),
            ],
            TextButton(
              child: Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                Get.showSnackbar(
                  GetSnackBar(message: 'Copied to clipboard'),
                );
                Get.back();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      }


  String checkStringType(String text) {
    final urlPatterns = [
      r"(https?|ftp)://([-A-Z0-9.]+)(/?[:]?\w+)*(/?[^#]*)#?([^?+]*?)?",
      r"(www.)?[-A-Za-z0-9]+\.[A-Za-z]{2,}",
    ];

    const phonePattern = r"^\d[\d\s-]{9,12}$";
    const wifiPattern =
        r"^(?:([0-9]{1,3}\.){3}[0-9]{1,3})|(?:([0-9A-Fa-f]{1,2}:){5}[0-9A-Fa-f]{1,2})$"; // Basic WiFi pattern (IP or MAC address)
    const emailPattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[-a-zA-Z0-9]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,}$"; // Basic email pattern
    const barcodePattern = r"^\d{8,13}$";

    // Check for email (consider adding more specific contact data checks)
    if (RegExp(emailPattern).hasMatch(text)||text.startsWith('mail')) {
      return 'Email';
    }
    // Check for vCard
    if (text.contains('BEGIN:VCARD') && text.contains('END:VCARD')) {
      return 'vCard';
    }
    //Check for sms
    if (text.startsWith('SMSTO:')) {
      return 'SMS';
    }
    // Check for URL first
    for (var pattern in urlPatterns) {
      if (RegExp(pattern).hasMatch(text)) {
        return 'URL';
      }
    }
  
    // Check for phone number
    if (RegExp(phonePattern).hasMatch(text)||text.startsWith('tel')||text.startsWith('+')) {
      return 'Phone Number';
    }

    // Check for WiFi data
    if (RegExp(wifiPattern).hasMatch(text)||text.startsWith('WIFI:S:')) {
      return 'WiFi';
    }

    // Check for Contact Data
    if (RegExp(emailPattern).hasMatch(text)) {
      return 'Contact Data';
    }

    // Check for barcode
    if (RegExp(barcodePattern).hasMatch(text)) {
      return 'Barcode Product Number';
    }

    // Check if all characters are numbers
    if (text.split('').every((char) => RegExp(r'[0-9]').hasMatch(char))) {
      return 'Number';
    }

    // Otherwise, consider it text
    return 'Text';
  }

}
