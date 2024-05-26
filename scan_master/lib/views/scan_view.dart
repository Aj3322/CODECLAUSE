import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/scan_controller.dart';
import 'app_drawer_view.dart';

class ScanView extends GetView<ScanViewController> {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: [
          QRView(
            key: controller.qrKey,
            onQRViewCreated: controller.onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'galleryButton',
                    onPressed: controller.openGallery,
                    child: const Icon(Icons.photo_library),
                  ),
                  FloatingActionButton(
                    heroTag: 'cameraButton',
                    onPressed: () {
                      controller.toggleCamera();
                    },
                    child: Obx(() => controller.isCameraPaused.value
                        ? const Icon(Icons.refresh)
                        : const Icon(Icons.camera)),
                  ),
                  FloatingActionButton(
                    heroTag: 'cameraFlipButton',
                    onPressed: () {
                      controller.qrController?.flipCamera();
                    },
                    child: Icon(Icons.flip_camera_ios_outlined),
                  ),
                  FloatingActionButton(
                    heroTag: 'flashButton',
                    onPressed: () {
                      controller.toggleFlash();
                    },
                    child: Obx(() {
                      switch (controller.flashState.value) {
                        case 'on':
                          return const Icon(Icons.flash_on);
                        case 'auto':
                          return const Icon(Icons.flash_auto);
                        case 'off':
                        default:
                          return const Icon(Icons.flash_off);
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
