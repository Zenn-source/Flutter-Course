import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsFeedCard(
          userName: 'Mackenzie Iguiron',
          postContent: 'Kamusta',
          numOfLikes: 100,
          date: 'November 29',
        ),
        NewsFeedCard(
          userName: 'Vergel Santiago',
          postContent: 'Hello everyone',
          numOfLikes: 210,
          hasImage: true,
          date: 'November 30',
        ),
      ],
    );
  }
}