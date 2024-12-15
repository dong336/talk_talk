class PostSimple {
  String id;
  String title;
  String category;
  String createdAt;

  PostSimple({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
  });

  factory PostSimple.fromJson(Map<String, dynamic> json) {
    return PostSimple(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        createdAt: json['created_at'],
    );
  }
}