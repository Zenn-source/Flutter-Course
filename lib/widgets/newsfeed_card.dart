import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "../constants.dart";
import "custom_font.dart";

class NewsFeedCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  const NewsFeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    this.hasImage = false,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: userName,
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomFont(
                          text: date,
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(3),
                        ),
                        Icon(
                          Icons.public,
                          color: Colors.grey,
                          size: ScreenUtil().setSp(15),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            // Post Content
            CustomFont(
              text: postContent,
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black,
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            hasImage == true
                ? const Placeholder()
                : SizedBox(
                    height: ScreenUtil().setHeight(1),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    print('Liked');
                  },
                  icon: const Icon(
                    Icons.thumb_up,
                    color: FB_DARK_PRIMARY,
                  ),
                  label: CustomFont(
                    text: numOfLikes.toString(),
                    fontSize: ScreenUtil().setSp(12),
                    color: FB_DARK_PRIMARY,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment,
                    color: FB_DARK_PRIMARY,
                  ),
                  label: CustomFont(
                    text: 'Comment',
                    fontSize: ScreenUtil().setSp(12),
                    color: FB_DARK_PRIMARY,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.redo,
                    color: FB_DARK_PRIMARY,
                  ),
                  label: CustomFont(
                    text: 'Share',
                    fontSize: ScreenUtil().setSp(12),
                    color: FB_DARK_PRIMARY,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(10), 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(330),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setSp(10))),
                  ),
                  child: CustomFont(
                    text: 'Write a comment...',
                    fontSize: ScreenUtil().setSp(11),
                    color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            CustomFont(
              text: 'View comments',
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}