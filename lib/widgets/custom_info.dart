import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
// IMPORT YOUR DETAIL SCREEN HERE
import '../screens/detail_screen.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    required this.name,
    required this.post, // This acts as your date
    required this.description, // This acts as your post content
    this.icon = const Icon(Icons.person),
    this.userImage = '',
    this.atProfile = false,
    this.date = '',
    this.contentImage = '',
    this.numOfLikes = 0,
  });

  final String name;
  final String post;
  final String description;
  final Icon icon;
  final String userImage;
  final String date;
  final int numOfLikes;
  final String contentImage;
  final bool atProfile;

  @override
  Widget build(BuildContext context) {
    // 1. Wrap everything in a GestureDetector to detect clicks
    return GestureDetector(
      onTap: () {
        // 2. Navigate to DetailScreen when clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userName: name,
              postContent: description,
              // If 'post' holds the time like "2 hrs ago", pass it here
              date: post,
              userImage: userImage,
              contentImage: contentImage,
              numOfLikes: numOfLikes,
            ),
          ),
        );
      },
      child: Container(
        // Added color transparent to ensure the empty space in the row is also clickable
        color: Colors.transparent,
        padding: EdgeInsets.all(ScreenUtil().setSp(15)),
        child: Row(
          children: [
            (userImage.isNotEmpty)
                ? CircleAvatar(
                    radius: ScreenUtil().setSp(25),
                    // Ensure you use AssetImage if your images are in the assets folder
                    backgroundImage: AssetImage(userImage),
                  )
                : Icon(Icons.person, size: ScreenUtil().setSp(50)),

            SizedBox(width: ScreenUtil().setWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFont(
                  text: name,
                  fontSize: ScreenUtil().setSp(20),
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                CustomFont(
                  text: 'Posted: $post',
                  fontSize: ScreenUtil().setSp(13),
                  color: Colors.black,
                ),
                CustomFont(
                  text: description,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
