class PlaylistItem {
  final int id;
  final String name;
  final String image;
  final String date;

  PlaylistItem({required this.id, required this.name, required this.image, required this.date});

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    return PlaylistItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      date: json['date'],
    );
  }
}
