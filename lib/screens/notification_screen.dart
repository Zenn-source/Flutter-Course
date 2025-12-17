import '../widgets/custom_info.dart' as info;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> notifications = [
    {
      'name': 'Lebron James',
      'post': 'commented on your post.',
      'description': '"Nice work on the Flutter project!"',
    },
    {
      'name': 'Tyler',
      'post': 'liked your photo.',
      'description': 'Your photo reached 167 likes.',
    },
    {
      'name': 'Nicole',
      'post': 'shared your video.',
      'description': 'Click to see the share.',
    },
    {
      'name': 'Security Alert',
      'post': 'New login detected.',
      'description': 'Was this you?',
    },
    {
      'name': 'Event Reminder',
      'post': 'invited you to Notion Meeting.',
      'description': 'December 13 at 4:00 PM.',
    },
    {
      'name': 'New login detected',
      'post': 'at Manila, Philippines.',
      'description': 'Yesterday at 9:00 PM.',
    },
    {
      'name': 'Ronald marked safe',
      'post': 'at Sta. Cruz, Zambales',
      'description': '12:32 AM.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView.separated(
        itemCount: notifications.length, 
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return info.CustomInformation(
            name: notification['name']!,    
            post: notification['post']!,
            description: notification['description']!,
          );
        },
      ),
    );
  }
}