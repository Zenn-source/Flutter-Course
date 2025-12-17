import 'package:iguiron_mobprog/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_font.dart';

class DetailScreen extends StatelessWidget {
  final String userName;
  final String userImage;
  final String postContent;
  final String date;
  int numOfLikes;
  final String contentImage;

  DetailScreen({
    super.key,
    required this.userName,
    this.userImage = '',
    required this.postContent,
    this.numOfLikes = 0,
    required this.date,
    this.contentImage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomFont(
          text: userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              (contentImage == '')
                  ? SizedBox(height: ScreenUtil().setHeight(0))
                  : Image.network(contentImage),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (userImage == '')
                        ? const Icon(Icons.person)
                        : CircleAvatar(
                            radius: ScreenUtil().setSp(25),
                            backgroundImage: NetworkImage(contentImage),
                          ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: userName,
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomFont(
                              text: date,
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.grey,
                            ),
                            SizedBox(width: ScreenUtil().setWidth(3)),
                            Icon(
                              Icons.public,
                              color: Colors.grey,
                              size: ScreenUtil().setSp(18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.more_horiz),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: postContent,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        print('Licked');
                      },
                      icon: const Icon(Icons.thumb_up, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: (numOfLikes == 0)
                            ? 'Like'
                            : numOfLikes.toString(),
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Comment',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Share',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
