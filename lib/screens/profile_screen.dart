import 'package:iguiron_mobprog/constants.dart';
import 'package:iguiron_mobprog/widgets/custom_button.dart';
import 'package:iguiron_mobprog/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iguiron_mobprog/widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/me.jpg'),
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
                      text: widget.username,
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
                    Column(
                      children: [
                        PostCard(
                          userName: widget.username,
                          userImage: 'assets/images/me.jpg',
                          postContent: 'Just finished the mobile dev project!',
                          date: 'December 12',
                          numOfLikes: 167,
                        ),
                        PostCard(
                          userName: widget.username,
                          userImage: 'assets/images/me.jpg',
                          postContent: 'Went to this amazing scenery!',
                          date: 'December 7',
                          contentImage: 'assets/images/mtfuji.jpg',
                          numOfLikes: 210,
                        ),
                      ],
                    ),

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
