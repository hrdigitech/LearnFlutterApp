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
      date: json['date'] as String?,
      views: json['view'] as int?,
    );
  }
}
