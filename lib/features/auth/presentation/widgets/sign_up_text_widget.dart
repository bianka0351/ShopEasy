import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/constants/app_routes.dart';

class SignUpTextWidget extends StatelessWidget {
  const SignUpTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppFonts.notoRegular(fontSize: 14, color: Colors.grey),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.signUpPage),
          child: Text(
            'Sign Up',
            style: AppFonts.notoSemiBold(
              fontSize: 14,
              color: Color(0xFFD64545),
            ),
          ),
        ),
      ],
    );
  }
}
