import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            IconData iconData;
            String label;

            switch (index) {
              case 0:
                iconData = Icons.home;
                label = 'Home';
                break;
              case 1:
                iconData = Icons.shopping_cart;
                label = 'Cart';
                break;
              default:
                iconData = Icons.person;
                label = 'Profile';
            }

            final isSelected = index == currentIndex;

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFE6EA)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                      child: Icon(
                        iconData,
                        key: ValueKey<bool>(isSelected),
                        color: isSelected
                            ? const Color(0xFFD64545)
                            : Colors.grey,
                        size: isSelected ? 28 : 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFFD64545)
                            : Colors.grey,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: isSelected ? 14 : 12,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Text(label),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
