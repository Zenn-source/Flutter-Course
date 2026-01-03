import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_font.dart';
import '../screens/detail_screen.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: CustomFont(
        text: label,
        fontSize: ScreenUtil().setSp(12),
        color: color,
      ),
    );
  }
}
class PostCard extends StatefulWidget {
  final String userName;
  final String userImage;
  final String postContent;
  final String date;
  final int numOfLikes;
  final String? contentImage;

  const PostCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.postContent,
    this.numOfLikes = 0,
    this.contentImage,
    required this.date,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _currentLikes;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.numOfLikes;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _currentLikes--;
        _isLiked = false;
      } else {
        _currentLikes++;
        _isLiked = true;
      }
    });
  }

  void _navigateToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          userName: widget.userName,
          userImage: widget.userImage,
          postContent: widget.postContent,
          numOfLikes: _currentLikes,
          date: widget.date,
          contentImage: widget.contentImage ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _navigateToDetail,
              child: Container(
                color: Colors
                    .transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(widget.userImage),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFont(
                              text: widget.userName,
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                CustomFont(
                                  text: widget.date,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: Colors.grey,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(3)),
                                Icon(
                                  Icons.public,
                                  color: Colors.grey,
                                  size: ScreenUtil().setSp(15),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_horiz),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    // Post Content
                    CustomFont(
                      text: widget.postContent,
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.black,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    // Content Image
                    widget.contentImage != null
                        ? Image.asset(
                            widget.contentImage!,
                            height: ScreenUtil().setHeight(350),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.thumb_up,
                  label: '$_currentLikes',
                  color: _isLiked ? Colors.blue : FB_DARK_PRIMARY,
                  onPressed: _toggleLike,
                ),
                ActionButton(
                  icon: Icons.comment,
                  label: 'Comment',
                  color: FB_DARK_PRIMARY,
                  onPressed: _navigateToDetail,
                ),
                ActionButton(
                  icon: Icons.redo,
                  label: 'Share',
                  color: FB_DARK_PRIMARY,
                  onPressed: () {},
                ),
              ],
            ),

            Row(
              children: [
                const CircleAvatar(
                  radius: 13,
                  backgroundImage: AssetImage('assets/images/me.jpg'),
                ),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Container(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(10), 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(330),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setSp(10)),
                    ),
                  ),
                  child: CustomFont(
                    text: 'Write a comment...',
                    fontSize: ScreenUtil().setSp(11),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            GestureDetector(
              onTap: _navigateToDetail,
              child: CustomFont(
                text: 'View comments',
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
