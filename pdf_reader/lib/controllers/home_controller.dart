import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pdf_file.dart';
import 'dart:async';
class HomeController extends GetxController {
  var pdfList = <PDFFile>[].obs;
  var pdf = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPdfFiles();
    // getAllPdfFiles();
  }

  Future<List<String>> getAllPdfFiles() async {

    final allPaths = <String>[];
    // Get internal storage path
    final internalPath = await getApplicationDocumentsDirectory();
      print("Path Internal  $internalPath");
    // Get external storage paths (if available)
    final externalPaths = await getExternalStorageDirectories();

    // Loop through internal and external paths
    for (var directory in [internalPath, ...?externalPaths]) {
      print(directory);
      // await _getAllPdfFilesFromDirectory(directory.path, allPaths);
        }
    print("Data is :      ========================>");
    print(allPaths.length);
    return allPaths;
  }

  // Future<void> _getAllPdfFilesFromDirectory(String directoryPath, List<String> allPaths) async {
  //   final files = Directory('/storage/emulated/0/aj').list(recursive: true);
  //   // Convert stream to a list using await and listen
  //   final listedFiles = await files.toList();
  //     print(files.length);
  //   for (var file in listedFiles) {
  //     if (file.path.endsWith('.pdf')) {
  //       allPaths.add(file.path);
  //     }
  //   }
  // }

  void fetchPdfFiles() async {
    // getAllPdfFiles();
    final files = await Directory('/storage/emulated/0/aj').list(recursive: true);
    var v = await files.first.toString();
        print(v);
    // Convert stream to a list using await and listen
    // final listedFiles = await files.toList();
    // print(listedFiles.length);
    // for (var file in listedFiles) {
    //   if (file.path.endsWith('.pdf')) {
    //
    //   }
    // }
    // PDFService pdfService = Get.put(PDFService());
    // final List<PDFFile> pdfFiles = await PDFService.getAllPDFFiles();
    // print(pdfFiles.length);
    // pdfList.assignAll(pdfFiles);
  }
}
