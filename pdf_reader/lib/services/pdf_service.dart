import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'dart:async';

import '../models/pdf_file.dart';

class PDFService extends GetxService {

  static Future<List<PDFFile>> getAllPDFFiles() async {
    final List<PDFFile> pdfFiles = [];

    // Request external storage permission
    final PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      // Permission granted, proceed with accessing external storage
      final Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        final List<PDFFile> externalPDFs = await _getPDFFilesFromDirectory(externalDir.path);
        pdfFiles.addAll(externalPDFs);
      }
    } else {

      print('Permission denied for accessing external storage');
    }

    // Get internal storage directory
    final Directory internalDir = await getApplicationDocumentsDirectory();
    final List<PDFFile> internalPDFs = await _getPDFFilesFromDirectory(internalDir.path);
    pdfFiles.addAll(internalPDFs);

    return pdfFiles;
  }

  static Future<List<PDFFile>> _getPDFFilesFromDirectory(String directoryPath) async {
    final Directory directory = Directory(directoryPath);
    final List<FileSystemEntity> entities = directory.listSync(recursive: true);
    final List<PDFFile> pdfFiles = [];

    await Future.forEach(entities, (FileSystemEntity entity) async {
      if (entity is File && entity.path.toLowerCase().endsWith('.pdf')) {
        final FileStat fileStat = await entity.stat();
        pdfFiles.add(PDFFile(
          name: entity.path.split('/').last,
          path: entity.path,
          type: 'application/pdf',
          size: fileStat.size,
          dateModified: fileStat.modified,
        ));
      }
    });

    return pdfFiles;
  }
}
