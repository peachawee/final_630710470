class TeamItem {
  final int id;
  final String name;
  final String group;
  final String image;

  TeamItem({
    required this.id,
    required this.name,
    required this.group,
    required this.image
  });

  factory TeamItem.fromJson(Map<String, dynamic> json) {
    return TeamItem(
      id: json['id'],
      name: json['name'],
      group: json['group'],
      image: json['image'],
    );
  }
}