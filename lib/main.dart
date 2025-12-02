import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iguiron_mobprog/screens/home_screen.dart';
import 'package:iguiron_mobprog/screens/newsfeed_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iguiron_mobprog/screens/notification_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Iguiron Facebook',
          initialRoute: '/home',
          routes: {
            '/newsfeed': (context) => const NewsfeedScreen(),
            '/home': (context) => const HomeScreen(),
            '/notifications': (context) => const NotificationScreen(),
          },
        );
      },
    ); 
  }
}
