import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/post_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. RAW DATA
    final List<Map<String, dynamic>> allPosts = [
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
        'content': 'Escape to paradise!',
        'likes': 892,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
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
        'name': 'FitLife Gym',
        'userImage': 'assets/images/gym_logo.jpg',
        'content': 'Transform your body!',
        'likes': 567,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
           'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
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
        'name': 'TechGear Pro',
        'userImage': 'assets/images/tech_logo.jpg',
        'content': 'New wireless earbuds!',
        'likes': 1203,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
           'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        ],
        'isAd': true,
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
        'name': 'Gourmet Bites',
        'userImage': 'assets/images/food_logo.jpg',
        'content': 'Delicious meals delivered to your door!',
        'likes': 743,
        'date': 'Sponsored',
        'contentImage': null,
        'carouselImages': [
           'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
        ],
        'isAd': true,
      },
    ];

    // 2. SEPARATE DATA
    final adPosts = allPosts.where((post) => post['isAd'] == true).toList();
    final regularPosts = allPosts.where((post) => post['isAd'] != true).toList();

    return Scaffold(
      body: ListView.builder(
        // Total items = regular posts + an ad section after each regular post (except maybe the last one if desired, but here we do all)
        itemCount: regularPosts.length * 2, 
        itemBuilder: (context, index) {
          
          // EVEN INDEX (0, 2, 4...) -> SHOW REGULAR POST
          if (index.isEven) {
            final postIndex = index ~/ 2; // integer division
            if (postIndex < regularPosts.length) {
              return _buildPost(regularPosts[postIndex]);
            }
          }

          // ODD INDEX (1, 3, 5...) -> SHOW CAROUSEL ADS
          // This ensures the "Carousel" appears after every single post.
          if (adPosts.isNotEmpty) {
            return _buildAdSection(adPosts);
          }

          return const SizedBox.shrink(); // Fallback
        },
      ),
    );
  }

  // Helper to build a regular post
  Widget _buildPost(Map<String, dynamic> post) {
    return PostCard(
      userName: post['name'],
      userImage: post['userImage'],
      postContent: post['content'],
      numOfLikes: post['likes'],
      date: post['date'],
      contentImage: post['contentImage'],
      carouselImages: post['carouselImages'] != null
          ? List<String>.from(post['carouselImages'])
          : null,
      isAdvertisement: false,
    );
  }

  // Helper Widget: Horizontal Ad Section (The Carousel)
  Widget _buildAdSection(List<Map<String, dynamic>> ads) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        //   child: Text(
        //     "Advertisement/ Promotion",
        //     style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black87,
        //     ),
        //   ),
        // ),
        
        SizedBox(
          // HEIGHT: 310 to prevent overflow for the rectangular ads
          height: ScreenUtil().setHeight(310), 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ads.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final post = ads[index];
              return Container(
                width: ScreenUtil().setWidth(300), // Fixed width for landscape card
                margin: const EdgeInsets.only(right: 8, bottom: 4),
                child: PostCard(
                  userName: post['name'],
                  userImage: post['userImage'],
                  postContent: post['content'],
                  numOfLikes: post['likes'],
                  date: post['date'],
                  contentImage: post['contentImage'],
                  carouselImages: post['carouselImages'] != null
                      ? List<String>.from(post['carouselImages'])
                      : null,
                  isAdvertisement: true, // Triggers small layout & hidden footer
                ),
              );
            },
          ),
        ),
        const Divider(height: 30, thickness: 1),
      ],
    );
  }
}