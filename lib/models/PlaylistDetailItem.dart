class PlaylistDetailsItem {
  String? id;
  String? title;
  String? image;
  String? description;
  String? date;
  int? views;

  PlaylistDetailsItem({this.id, this.title, this.image, this.description, this.date, this.views});

  factory PlaylistDetailsItem.fromJson(Map<String, dynamic> json) {
    return PlaylistDetailsItem(
      id: json['id'].toString(),
      title: json['title'] as String?,
      image: json['thumbnail'] as String?,
      description: json['description'] as String?,
      date: extractDate(json['created_at'] as String?), // Extract only the date
      views: json['view'] as int?,
    );
  }

  // Method to extract date from the created_at string
  static String? extractDate(String? createdAt) {
    if (createdAt != null) {
      // Split the string by 'T' and return the first part (the date)
      return createdAt.split('T').first;
    }
    return null; // Return null if createdAt is null
  }
}
