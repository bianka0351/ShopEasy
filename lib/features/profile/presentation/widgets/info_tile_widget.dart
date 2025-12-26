import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class InfoTileWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const InfoTileWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (icon != null)
                Icon(icon, size: 20, color: const Color(0xFFD64545)),
              if (icon != null) const SizedBox(width: 10),
              // Text(
              //   '$label:',
              //   style: AppFonts.notoMedium(
              //     fontSize: 14,
              //     color: Colors.grey[800],
              //   ),
              // ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: AppFonts.notoRegular(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
