import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageRepo {
  StorageRepo._privateConstructor();
  static final StorageRepo _instance = StorageRepo._privateConstructor();
  factory StorageRepo() {
    return _instance;
  }


  final FirebaseStorage _storage = FirebaseStorage.instance;


  Future<String> uploadFile(File file, String path, String fileType) async {
    try {
      String fileName = _generateUniqueFileName(file);
      String fullPath = '$path/$fileType/$fileName';
      Reference ref = _storage.ref().child(fullPath);
      await ref.putFile(file);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getFileURL(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _generateUniqueFileName(File file) {
    return DateTime.now().millisecondsSinceEpoch.toString() + '_' + file.uri.pathSegments.last;
  }
}
