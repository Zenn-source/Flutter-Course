import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

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
        'isAd': false,
      },
      {
        'name': 'Tropical Paradise Resort',
        'userImage': 'assets/images/resort_logo.jpg',
        'content': 'Escape to paradise! Book your dream vacation today. 🏝️',
        'likes': 892,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        ],
        'isAd': true,
      },
      {
        'name': 'Mackenzie Iguiron',
        'userImage': 'assets/images/me.jpg',
        'content': 'Went to this amazing scenery!',
        'likes': 210,
        'date': 'December 7',
        'contentImage': 'assets/images/mtfuji.jpg',
        'isAd': false,
      },
      {
        'name': 'Tropical Paradise Resort',
        'userImage': 'assets/images/resort_logo.jpg',
        'content': 'Escape to paradise! Book your dream vacation today. 🏝️',
        'likes': 892,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        ],
        'isAd': true,
      },
      {
        'name': 'Lebron James',
        'userImage': 'assets/images/LJ.png',
        'content': 'Kapagod mag ball ',
        'likes': 45,
        'date': 'December 6',
        'contentImage': 'assets/images/lebron!.png',
        'isAd': false,
      },
      {
        'name': 'Tyler',
        'userImage': 'assets/images/tyler.jpg',
        'content': 'Thanks for coming to my concert!',
        'likes': 6734,
        'date': 'December 4',
        'contentImage': 'assets/images/tylercon.jpg',
        'isAd': false,
      },
      {
        'name': 'TechGear Pro',
        'userImage': 'assets/images/tech_logo.jpg',
        'content':
            'New wireless earbuds - 50% off this week only! Premium sound quality.',
        'likes': 1203,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=800',
          'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800',
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=800',
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        ],
        'isAd': true,
      },
      {
        'name': 'Vergel',
        'userImage': 'assets/images/download.jpeg',
        'content': 'Check out this cool view.',
        'likes': 32,
        'date': 'December 2',
        'contentImage': 'assets/images/cats.jpg',
        'isAd': false,
      },
      {
        'name': 'FitLife Gym',
        'userImage': 'assets/images/gym_logo.jpg',
        'content':
            'Transform your body! Join now and get 1 month free. Limited slots available.',
        'likes': 567,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
          'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800',
          'https://images.unsplash.com/photo-1574680096145-d05b474e2155?w=800',
          'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800',
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
        ],
        'isAd': true,
      },
      {
        'name': 'Jaime Santiago',
        'userImage': 'assets/images/professional.jpg',
        'content':
            'Just finished a meeting with my coleagues. Can say it was a great way to end the day!',
        'likes': 6,
        'date': 'November 21',
        'contentImage': 'assets/images/meeting.png',
        'isAd': false,
      },
      {
        'name': 'Mackenzie Iguiron',
        'userImage': 'assets/images/me.jpg',
        'content': 'Hi Guys!',
        'likes': 1,
        'date': 'October 10',
        'contentImage': null,
        'isAd': false,
      },
      {
        'name': 'Gourmet Bites',
        'userImage': 'assets/images/food_logo.jpg',
        'content':
            'Delicious meals delivered to your door! Use code FEAST20 for 20% off.',
        'likes': 743,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
        ],
        'isAd': true,
      },
      {
        'name': 'Tyler',
        'userImage': 'assets/images/tyler.jpg',
        'content': 'Go to my concert please!',
        'likes': 1001,
        'date': 'December 21',
        'contentImage': null,
        'isAd': false,
      },
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(
          userName: posts[index]['name'],
          userImage: posts[index]['userImage'],
          postContent: posts[index]['content'],
          numOfLikes: posts[index]['likes'],
          date: posts[index]['date'],
          contentImage: posts[index]['contentImage'],
          carouselImages: posts[index]['carouselImages'] != null
              ? List<String>.from(posts[index]['carouselImages'])
              : null,
          isAdvertisement: posts[index]['isAd'] ?? false,
        );
      },
    );
  }
}
