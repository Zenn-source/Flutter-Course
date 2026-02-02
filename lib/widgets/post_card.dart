import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  final List<String>? carouselImages;
  final bool isAdvertisement;

  const PostCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.postContent,
    this.numOfLikes = 0,
    this.contentImage,
    this.carouselImages,
    required this.date,
    this.isAdvertisement = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _currentLikes;
  bool _isLiked = false;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.numOfLikes;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  bool _isNetworkImage(String? imagePath) {
    if (imagePath == null) return false;
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }

  Widget _buildCarouselImage(String imagePath) {
    if (_isNetworkImage(imagePath)) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.error_outline, color: Colors.grey, size: 50),
        ),
      );
    } else {
      return Image.asset(imagePath, fit: BoxFit.cover);
    }
  }

  Widget _buildContentImage() {
    // If carousel images exist (for ads)
    if (widget.carouselImages != null && widget.carouselImages!.isNotEmpty) {
      return Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(350),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.carouselImages!.length,
              itemBuilder: (context, index) {
                return _buildCarouselImage(widget.carouselImages![index]);
              },
            ),
          ),
          if (widget.carouselImages!.length > 1)
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.carouselImages!.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(4),
                    ),
                    width: _currentPage == index ? 8.0 : 6.0,
                    height: _currentPage == index ? 8.0 : 6.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // Single image
    if (widget.contentImage != null) {
      if (_isNetworkImage(widget.contentImage)) {
        return CachedNetworkImage(
          imageUrl: widget.contentImage!,
          height: ScreenUtil().setHeight(350),
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: ScreenUtil().setHeight(350),
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            height: ScreenUtil().setHeight(350),
            width: double.infinity,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.grey[600], size: 50),
                const SizedBox(height: 10),
                CustomFont(
                  text: 'Failed to load image',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[600]!,
                ),
              ],
            ),
          ),
        );
      } else {
        return Image.asset(
          widget.contentImage!,
          height: ScreenUtil().setHeight(350),
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Advertisement/Promotion Label
        if (widget.isAdvertisement)
          Padding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(10),
              ScreenUtil().setSp(10),
              ScreenUtil().setSp(10),
              0,
            ),
            child: CustomFont(
              text: 'Advertisement/Promotion',
              fontSize: ScreenUtil().setSp(11),
              color: Colors.grey[600]!,
              fontWeight: FontWeight.w500,
            ),
          ),
        Card(
          margin: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _navigateToDetail,
                  child: Container(
                    color: Colors.transparent,
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
                        CustomFont(
                          text: widget.postContent,
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(5)),
                        _buildContentImage(),
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
                      padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setSp(10),
                        0,
                        0,
                        0,
                      ),
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
        ),
      ],
    );
  }
}
