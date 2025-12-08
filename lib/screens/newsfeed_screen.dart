// lib/screens/newsfeed_screen.dart
import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> posts = [
      {
        'name': 'Mackenzie Iguiron',
        'userImage': 'assets/images/me.jpg',
        'content': 'Just finished the mobile dev project!',
        'likes': 150,
        'date': 'December 8',
        'contentImage': null, 
      },
      {
        'name': 'Tyler',
        'userImage': 'assets/images/tyler.jpg',
        'content': 'Check out this cool view.',
        'likes': 210,
        'date': 'December 7',
        'contentImage': 'assets/images/owl.jpg',
      },
      {
        'name': 'Lebron James',
        'userImage': 'assets/images/owl.jpg',
        'content': 'Coding is fun but tiring.',
        'likes': 45,
        'date': 'December 6',
        'contentImage': null,
      },
      {
        'name': 'Mackenzie Iguiron',
        'userImage': 'assets/images/me.jpg',
        'content': 'Hi Guys!',
        'likes': 1,
        'date': 'October 10',
        'contentImage': null,
      },
      {
        'name': 'Tyler',
        'userImage': 'assets/images/tyler.jpg',
        'content': 'Go to my concert please!',
        'likes': 1001,
        'date': 'December 21',
        'contentImage': null,
      },
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return NewsFeedCard(
          userName: posts[index]['name'],
          userImage: posts[index]['userImage'],
          postContent: posts[index]['content'],
          numOfLikes: posts[index]['likes'],
          date: posts[index]['date'],
          contentImage: posts[index]['contentImage'],
        );
      },
    );
  }
}