import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
import '../screens/detail_screen.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    required this.name,
    required this.post,
    required this.description,
    required this.imagePath,
    this.icon = const Icon(Icons.person),
    this.atProfile = false,
    this.date = '',
    this.contentImage = '',
    this.numOfLikes = 0,
  });

  final String name;
  final String post;
  final String description;
  final Icon icon;
  final String imagePath;
  final String date;
  final int numOfLikes;
  final String contentImage;
  final bool atProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userName: name,
              postContent: description,
              date: post,
              userImage: imagePath,
              contentImage: contentImage,
              numOfLikes: numOfLikes,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(ScreenUtil().setSp(15)),
        child: Row(
          children: [
            (imagePath.isNotEmpty)
                ? CircleAvatar(
                    radius: ScreenUtil().setSp(25),
                    backgroundImage: AssetImage(imagePath),
                    backgroundColor: Colors.grey.shade200,
                  )
                : Icon(Icons.person, size: ScreenUtil().setSp(50)),

            SizedBox(width: ScreenUtil().setWidth(10)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: name,
                    fontSize: ScreenUtil().setSp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  CustomFont(
                    text:
                        post,
                    fontSize: ScreenUtil().setSp(13),
                    color: Colors.black,
                  ),
                  CustomFont(
                    text: description,
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ],
              ),
            ),

            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
