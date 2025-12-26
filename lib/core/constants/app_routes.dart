import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/presentation/pages/login_page.dart';
import 'package:shop_easy/features/auth/presentation/pages/sign_up_page.dart';
import 'package:shop_easy/features/home/presentation/pages/home_page.dart';
import 'package:shop_easy/features/navigation/presentation/main_layout.dart';
import 'package:shop_easy/features/product_details/presentation/pages/product_details_page.dart';

class AppRoutes {
  static const String loginPage = '/login_page';
  static const String signUpPage = '/sign_up_page';
  static const String productDetailsPage = '/details';
  static const String homePage = '/home_page';
  static const String mainLayout = '/main';
  static Map<String, WidgetBuilder> routes = {
    loginPage: (context) => LoginPage(),
    signUpPage: (context) => SignUpPage(),
    productDetailsPage: (context) => const ProductDetailsPage(),
    homePage: (context) => const HomePage(),
    mainLayout: (_) => const MainLayout(),
  };
}
