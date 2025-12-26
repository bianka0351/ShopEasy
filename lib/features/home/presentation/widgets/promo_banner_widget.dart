import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/beauty_sale_banner.png',
            height: 160,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),

        const SizedBox(height: 16),

        // Friendly Text
        Text(
          '✨ Discover your beauty essentials',
          style: AppFonts.notoMedium(fontSize: 16),
        ),

        const SizedBox(height: 4),

        Text(
          'Hand-picked products just for you',
          style: AppFonts.notoMedium(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
