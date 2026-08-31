import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';
import '../widgets/post_card.dart';

class NewsfeedScreen extends StatefulWidget {
  final User currentUser;

  const NewsfeedScreen({super.key, required this.currentUser});

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  final List<Map<String, dynamic>> _ads = [
    {
      'name': 'Tropical Paradise Resort',
      'userImage': 'assets/images/resort_logo.jpg',
      'content': 'Escape to paradise! Book your dream vacation today. 🏝️',
      'likes': 892,
      'carouselImages': [
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
        'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
      ],
    },
    {
      'name': 'TechGear Pro',
      'userImage': 'assets/images/tech_logo.jpg',
      'content':
          'New wireless earbuds - 50% off this week only! Premium sound quality.',
      'likes': 1203,
      'carouselImages': [
        'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=800',
        'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800',
        'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=800',
        'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
      ],
    },
    {
      'name': 'FitLife Gym',
      'userImage': 'assets/images/gym_logo.jpg',
      'content':
          'Transform your body! Join now and get 1 month free. Limited slots available.',
      'likes': 567,
      'carouselImages': [
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
        'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800',
        'https://images.unsplash.com/photo-1574680096145-d05b474e2155?w=800',
        'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800',
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
      ],
    },
    {
      'name': 'Gourmet Bites',
      'userImage': 'assets/images/food_logo.jpg',
      'content':
          'Delicious meals delivered to your door! Use code FEAST20 for 20% off.',
      'likes': 743,
      'carouselImages': [
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
      ],
    },
  ];

  List<Post> _posts = [];
  Map<int, User> _usersById = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        _postService.getPosts(limit: 20),
        _userService.getAllUsers(),
      ]);

      final posts = results[0] as List<Post>;
      final users = results[1] as List<User>;

      setState(() {
        _posts = posts;
        _usersById = {for (final user in users) user.id: user};
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load newsfeed';
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildFeedItems() {
    final items = <Widget>[];
    int adIndex = 0;

    for (int i = 0; i < _posts.length; i++) {
      final post = _posts[i];
      final author = _usersById[post.userId];

      items.add(
        PostCard(
          userName: author?.fullName ?? 'Unknown User',
          userImage: author?.image ?? 'assets/images/me.jpg',
          postContent: post.body,
          numOfLikes: post.likes,
          date: '',
          postId: post.id,
          currentUser: widget.currentUser,
        ),
      );

      if ((i + 1) % 3 == 0 && _ads.isNotEmpty) {
        final ad = _ads[adIndex % _ads.length];
        adIndex++;
        items.add(
          PostCard(
            userName: ad['name'],
            userImage: ad['userImage'],
            postContent: ad['content'],
            numOfLikes: ad['likes'],
            date: 'Sponsored',
            carouselImages: List<String>.from(ad['carouselImages']),
            isAdvertisement: true,
          ),
        );
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _loadFeed, child: const Text('Retry')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFeed,
      child: ListView(children: _buildFeedItems()),
    );
  }
}
