import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../models/user.dart';
import '../providers/theme_provider.dart';
import '../services/user_service.dart';
import '../widgets/custom_font.dart';
import 'signin_screen.dart';

class SettingsScreen extends StatelessWidget {
  final User user;

  const SettingsScreen({super.key, required this.user});

  Future<void> _signOut(BuildContext context) async {
    await UserService.clearSession();
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: CustomFont(
          text: 'Settings',
          fontSize: ScreenUtil().setSp(20),
          color: FB_PRIMARY,
          fontFamily: 'Klavika',
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(20)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: ScreenUtil().setSp(30),
                  backgroundImage: CachedNetworkImageProvider(user.image),
                ),
                SizedBox(width: ScreenUtil().setWidth(15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: user.fullName,
                        fontSize: ScreenUtil().setSp(18),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomFont(
                        text: user.email,
                        fontSize: ScreenUtil().setSp(13),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          SwitchListTile(
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(value),
            activeThumbColor: FB_DARK_PRIMARY,
            title: CustomFont(
              text: 'Dark Mode',
              fontSize: ScreenUtil().setSp(15),
              color: Colors.black,
            ),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: CustomFont(
              text: 'Sign Out',
              fontSize: ScreenUtil().setSp(15),
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
