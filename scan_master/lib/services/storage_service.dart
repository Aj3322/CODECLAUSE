import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../models/scan_model.dart';

class StorageService {
  static late Box<ScanModel> _scanBox;
  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(ScanModelAdapter());
    _scanBox = await Hive.openBox<ScanModel>('scanBox');
  }
  static Box<ScanModel> get scanBox => _scanBox;
}
