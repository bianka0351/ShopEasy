import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Color(0xFFD64545),
      strokeWidth: 4,
      backgroundColor: Colors.transparent,
    );
  }
}
