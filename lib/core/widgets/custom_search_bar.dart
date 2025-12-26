import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final String hintText;
  const CustomSearchBar({
    required this.onChanged,
    required this.controller,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        style: AppFonts.notoMedium(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppFonts.notoMedium(
            fontSize: 14,
            color: Color(0xFFDDDDDD).withValues(alpha: 0.8),
          ),
          prefixIcon: Icon(Icons.search, color: Color(0xFFDDDDDD), size: 22),
          // suffixIcon: Icon(
          //   Icons.filter_alt_outlined,
          //   color: AppColors.secondaryAccentColor,
          //   size: 22.sp,
          // ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
