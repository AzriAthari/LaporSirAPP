class Report {
  final String title;
  final String location;
  final String complaint;
  final String? imagePath; // Properti untuk gambar

  Report({
    required this.title,
    required this.location,
    required this.complaint,
    this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'location': location,
        'complaint': complaint,
        'imagePath': imagePath,
      };

  static Report fromJson(Map<String, dynamic> json) {
    return Report(
      title: json['title'],
      location: json['location'],
      complaint: json['complaint'],
      imagePath: json['imagePath'],
    );
  }
}
