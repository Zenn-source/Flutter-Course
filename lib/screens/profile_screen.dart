import 'package:iguiron_mobprog/widgets/custom_button.dart';
import 'package:iguiron_mobprog/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iguiron_mobprog/widgets/post_card.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PostService _postService = PostService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _postService.getPostsByUser(widget.user.id);
  }

  Widget _buildPostsTab() {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('Failed to load posts')),
          );
        }

        final posts = snapshot.data ?? [];
        if (posts.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('No posts yet')),
          );
        }

        return Column(
          children: posts
              .map(
                (post) => PostCard(
                  userName: widget.user.fullName,
                  userImage: widget.user.image,
                  postContent: post.body,
                  date: '',
                  numOfLikes: post.likes,
                  postId: post.id,
                  currentUser: widget.user,
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/coverphoto.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: ScreenUtil().setWidth(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                            widget.user.image,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(55)),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: widget.user.fullName,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    Row(
                      children: [
                        CustomFont(
                          text: '192',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomFont(
                          text: 'followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Icon(
                          Icons.circle,
                          size: ScreenUtil().setSp(5),
                          color: Colors.grey,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: '178',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomFont(
                          text: 'following',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Row(
                      children: [
                        CustomButton(buttonName: 'Follow', onPressed: () {}),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomButton(
                          buttonName: 'Message',
                          onPressed: () {},
                          buttonType: 'outlined',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(10)),

              TabBar(
                indicatorColor:
                    Colors.blue,
                tabs: [
                  Tab(
                    child: CustomFont(
                      text: 'Posts',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    child: CustomFont(
                      text: 'About',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    child: CustomFont(
                      text: 'Photos',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: ScreenUtil().setHeight(2000),
                child: TabBarView(
                  children: [
                    // --- TAB 1: POSTS ---
                    _buildPostsTab(),

                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setSp(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFont(
                            text: 'Details',
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(20),
                            color: Colors.black,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                color: Colors.grey,
                                size: ScreenUtil().setSp(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'Student',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          Row(
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.grey,
                                size: ScreenUtil().setSp(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'Studies at National University',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.grey,
                                size: ScreenUtil().setSp(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'Lives in Manila, Philippines',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: ScreenUtil().setSp(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'In a relationship',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          const Icon(Icons.more_horiz, color: Colors.grey),
                        ],
                      ),
                    ),

                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.all(10),
                      children: [
                        Image.asset('assets/images/me.jpg', fit: BoxFit.cover),
                        Image.asset(
                          'assets/images/scenery.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/olaf.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset('assets/images/r34.jpg', fit: BoxFit.cover),
                        Image.asset(
                          'assets/images/japan.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/cats.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/mtfuji.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
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
