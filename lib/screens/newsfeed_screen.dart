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
        'likes': 167,
        'date': 'December 12',
        'contentImage': null, 
      },
      {
        'name': 'Mackenzie',
        'userImage': 'assets/images/me.jpg',
        'content': 'Went to this amazing scenery!',
        'likes': 210,
        'date': 'December 7',
        'contentImage': 'assets/images/scenery.jpg',
      },
      {
        'name': 'Lebron James',
        'userImage': 'assets/images/LJ.png',
        'content': 'Kapagod mag ball ',
        'likes': 45,
        'date': 'December 6',
        'contentImage': 'assets/images/lebron!.png',
      },
      {
        'name': 'Tyler',
        'userImage': 'assets/images/tyler.jpg',
        'content': 'Thanks for coming to my concert!',
        'likes': 6734,
        'date': 'December 4',
        'contentImage': 'assets/images/tylercon.jpg',
      },
      {
        'name': 'Vergel',
        'userImage': 'assets/images/download.jpeg',
        'content': 'Check out this cool view.',
        'likes': 32,
        'date': 'December 2',
        'contentImage': 'assets/images/cats.jpg',
      },
      {
        'name': 'Jaime Santiago',
        'userImage': 'assets/images/professional.jpg',
        'content': 'Just finished a meeting with my coleagues. Can say it was a great way to end the day!',
        'likes': 6,
        'date': 'November 21',
        'contentImage': 'assets/images/meeting.png',
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