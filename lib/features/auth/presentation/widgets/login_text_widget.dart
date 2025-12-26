import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class LoginTextWidget extends StatelessWidget {
  const LoginTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppFonts.notoRegular(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Log In',
            style: AppFonts.notoSemiBold(color: Color(0xFFD64545)),
          ),
        ),
      ],
    );
  }
}
