class PeopleAlsoViewItem {
  final int id;
  final String title;
  final String image;
  final String link;

  PeopleAlsoViewItem({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });

  factory PeopleAlsoViewItem.fromJson(Map<String, dynamic> json) {
    return PeopleAlsoViewItem(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      link: json['link'],
    );
  }
}
