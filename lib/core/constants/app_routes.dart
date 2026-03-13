import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/presentation/pages/login_page.dart';
import 'package:shop_easy/features/auth/presentation/pages/sign_up_page.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';
import 'package:shop_easy/features/home/presentation/pages/home_page.dart';
import 'package:shop_easy/features/navigation/presentation/main_layout.dart';
import 'package:shop_easy/features/product_details/presentation/pages/product_details_page.dart';

class AppRoutes {
  static const String loginPage = '/login_page';
  static const String signUpPage = '/sign_up_page';
  static const String productDetailsPage = '/details';
  static const String homePage = '/home_page';
  static const String mainLayout = '/main';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case signUpPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case mainLayout:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case productDetailsPage:
        final product = settings.arguments as ProductModel;

        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: product),
        );

      default:
        return null;
    }
  }
}
