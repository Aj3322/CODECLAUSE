import 'package:hive/hive.dart';
part 'scan_model.g.dart';

@HiveType(typeId: 0)
class ScanModel {
  @HiveField(0)
  final String data;
  @HiveField(1)
  final DateTime dateTime;

  ScanModel({required this.data, required this.dateTime});
}

