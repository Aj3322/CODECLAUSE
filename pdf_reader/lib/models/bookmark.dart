class Bookmark {
  final String pdfPath;
  final int pageNumber;
  final String name;
  final String type;

  Bookmark({
    required this.name,
    required this.type,
    required this.pdfPath,
    required this.pageNumber,
  });

  // Convert Bookmark object to a JSON Map
  Map<String, dynamic> toJson() => {
    'pdfPath': pdfPath,
    'pageNumber': pageNumber,
    'name': name,
    'type': type,
  };

  // Construct a Bookmark object from a JSON Map
  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
    pdfPath: json['pdfPath'],
    pageNumber: json['pageNumber'],
    name: json['name'],
    type: json['type'],
  );
}
