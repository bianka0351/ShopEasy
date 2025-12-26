import 'package:flutter/material.dart';
import 'package:shop_easy/core/services/local_storage_service.dart';
import 'package:shop_easy/features/profile/presentation/widgets/password_field_widget.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';

class EditProfileDialog {
  static void show(BuildContext context, LocalStorageService storage) {
    final TextEditingController usernameController = TextEditingController(
      text: storage.username ?? '',
    );
    final TextEditingController emailController = TextEditingController(
      text: storage.email ?? '',
    );
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit Profile',
          style: AppFonts.notoBold(
            fontSize: 20,
            color: const Color(0xFFD64545),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: AppFonts.notoMedium(color: Colors.grey[700]),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: AppFonts.notoMedium(color: Colors.grey[700]),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              PasswordFieldWidget(
                label: 'Password (optional)',
                controller: passwordController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: AppFonts.notoMedium(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD64545),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              if (usernameController.text.isNotEmpty) {
                await storage.updateUsername(usernameController.text);
              }
              if (emailController.text.isNotEmpty) {
                await storage.updateEmail(emailController.text);
              }
              if (passwordController.text.isNotEmpty) {
                await storage.updatePassword(passwordController.text);
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: Text(
              'Save',
              style: AppFonts.notoMedium(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
