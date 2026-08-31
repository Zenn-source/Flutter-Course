class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final int likes;
  final int dislikes;
  final List<String> tags;
  final int views;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.likes,
    required this.dislikes,
    required this.tags,
    required this.views,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final reactions = json['reactions'];
    return Post(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      likes: reactions != null ? ((reactions['likes'] as num?)?.toInt() ?? 0) : 0,
      dislikes: reactions != null ? ((reactions['dislikes'] as num?)?.toInt() ?? 0) : 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      views: json['views'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'reactions': {'likes': likes, 'dislikes': dislikes},
      'tags': tags,
      'views': views,
    };
  }
}
