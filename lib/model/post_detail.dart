class PostDetail {
  String id;
  String title;
  String category;
  String contents;
  String createdAt;
  String updatedAt;

  PostDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.contents,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        contents: json['contents'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']
    );
  }
}