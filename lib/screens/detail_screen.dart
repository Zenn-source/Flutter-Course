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
  final String? contentImage;

  DetailScreen({
    super.key,
    required this.userName,
    this.userImage = '',
    required this.postContent,
    this.numOfLikes = 0,
    required this.date,
    this.contentImage = '',
  });
  
}
