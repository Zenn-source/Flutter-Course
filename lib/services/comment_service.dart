import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/comment.dart';

class CommentService {
  final String host = 'https://dummyjson.com';

  Future<List<Comment>> getCommentsByPost(int postId) async {
    final uri = Uri.parse('$host/comments/post/$postId');
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List commentsJson = data['comments'] ?? [];
      return commentsJson.map((c) => Comment.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load comments: ${response.statusCode}');
    }
  }

  Future<Comment> addComment(int postId, String body, int userId) async {
    final uri = Uri.parse('$host/comments/add');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'body': body, 'postId': postId, 'userId': userId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Comment.fromJson(data);
    } else {
      throw Exception('Failed to add comment: ${response.statusCode}');
    }
  }
}
