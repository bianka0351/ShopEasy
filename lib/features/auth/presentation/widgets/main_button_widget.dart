import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class MainButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MainButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD64545),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 6,
        ),
        child: Text(
          text,
          style: AppFonts.notoSemiBold(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
