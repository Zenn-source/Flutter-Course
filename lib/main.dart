import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:iguiron_mobprog/providers/theme_provider.dart';
import 'package:iguiron_mobprog/screens/register_screen.dart';
import 'package:iguiron_mobprog/screens/signin_screen.dart';
import 'package:iguiron_mobprog/screens/splash_screen.dart';
import 'constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Iguiron Facebook',
          initialRoute: '/splash',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: FB_PRIMARY,
            colorScheme: ColorScheme.fromSeed(
              seedColor: FB_PRIMARY,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            primaryColor: FB_LIGHT_PRIMARY,
            colorScheme: ColorScheme.fromSeed(
              seedColor: FB_PRIMARY,
              brightness: Brightness.dark,
            ),
          ),
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/signin': (context) => const SignInScreen(),
            '/register': (context) => const RegisterScreen(),
          },
        );
      },
    );
  }
}
