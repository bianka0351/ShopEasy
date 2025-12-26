import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/constants/app_routes.dart';
import 'package:shop_easy/core/services/local_storage_service.dart';
import 'package:shop_easy/core/utils/validator.dart';
import 'package:shop_easy/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/sign_up_text_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/main_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  late LocalStorageService storageService;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      storageService = LocalStorageService(prefs);
    });
  }

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    /// Validate inputs
    if (!Validator.isNotEmpty(email) || !Validator.isNotEmpty(password)) {
      _showMessage('Please fill all fields');
      return;
    }

    if (!Validator.isEmailValid(email)) {
      _showMessage('Please enter a valid email');
      return;
    }

    /// Check if user exists
    if (!storageService.hasUser) {
      _showMessage('No account found, please sign up');
      return;
    }

    /// Validate login
    if (!storageService.validateLogin(email, password)) {
      _showMessage('Invalid email or password');
      return;
    }
    await storageService.setLoggedIn(true);

    /// Success → go to Home
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.mainLayout,
      (route) => false,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                'ShopEasy',
                style: AppFonts.notoBold(
                  color: Color(0xFFD64545),
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 60),
              InputFieldWidget(
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: emailController,
              ),
              const SizedBox(height: 16),
              InputFieldWidget(
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 28),
              MainButtonWidget(text: 'Log In', onPressed: _login),
              const SizedBox(height: 24),
              SignUpTextWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
