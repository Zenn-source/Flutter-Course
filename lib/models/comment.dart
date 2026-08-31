class CommentAuthor {
  final int id;
  final String username;
  final String fullName;

  CommentAuthor({required this.id, required this.username, required this.fullName});

  factory CommentAuthor.fromJson(Map<String, dynamic> json) {
    return CommentAuthor(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? (json['username'] ?? 'User'),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'fullName': fullName};
  }
}

class Comment {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final CommentAuthor user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      likes: json['likes'] ?? 0,
      user: CommentAuthor.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'body': body, 'postId': postId, 'likes': likes, 'user': user.toJson()};
  }
}
