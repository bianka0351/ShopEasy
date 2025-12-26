import 'package:flutter/material.dart';
import '../constants/app_fonts.dart';

class CustomErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String buttonText;

  const CustomErrorMessage({
    super.key,
    required this.message,
    required this.onRetry,
    this.buttonText = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ERROR MESSAGE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFB3640),
                  size: 26,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppFonts.notoMedium(
                      fontSize: 16,
                      color: const Color(0xFFFB3640),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// RETRY BUTTON
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onRetry,
              child: Container(
                width: 160,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh_outlined, size: 20),
                    const SizedBox(width: 6),
                    Text(buttonText, style: AppFonts.notoMedium(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
