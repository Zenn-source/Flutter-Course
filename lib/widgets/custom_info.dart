import '../widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/detail_screen.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    required this.name,
    required this.post,
    required this.description,
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
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(15)),
      child: Row(
        children: [
          Icon(Icons.person, size: ScreenUtil().setSp(50)),
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
    );
  }
}
