import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/constants/app_routes.dart';
import 'package:shop_easy/core/services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final storage = LocalStorageService(prefs);

    if (!mounted) return;

    if (storage.isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),
          // Container(color: Colors.black.withValues(alpha: 0.3)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ShopEasy',
                  style: AppFonts.notoBold(
                    color: Color(0xFFD64545),
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
