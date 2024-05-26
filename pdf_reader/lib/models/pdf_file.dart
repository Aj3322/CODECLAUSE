class PDFFile {
  final String name;
  final String path;
  final String type; // e.g., "application/pdf"
  final int size; // in bytes
  final DateTime dateModified;

  PDFFile({
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.dateModified,
  });

  // Convert PDFFile object to a JSON Map
  Map<String, dynamic> toJson() => {
    'name': name,
    'path': path,
    'type': type,
    'size': size,
    'dateModified': dateModified.toIso8601String(),
  };

  // Construct a PDFFile object from a JSON Map
  factory PDFFile.fromJson(Map<String, dynamic> json) => PDFFile(
    name: json['name'],
    path: json['path'],
    type: json['type'],
    size: json['size'],
    dateModified: DateTime.parse(json['dateModified']),
  );
}
