import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/constants/app_routes.dart';
import 'package:shop_easy/core/services/local_storage_service.dart';
import 'package:shop_easy/core/utils/validator.dart';
import 'package:shop_easy/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/login_text_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/main_button_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  late LocalStorageService storageService;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      storageService = LocalStorageService(prefs);
    });
  }

  void _signUp() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (!Validator.isNotEmpty(username) ||
        !Validator.isNotEmpty(email) ||
        !Validator.isNotEmpty(password) ||
        !Validator.isNotEmpty(confirmPassword)) {
      _showMessage('All fields are required');
      return;
    }

    if (!Validator.isEmailValid(email)) {
      _showMessage('Please enter a valid email');
      return;
    }

    if (!Validator.arePasswordsMatching(password, confirmPassword)) {
      _showMessage('Passwords do not match');
      return;
    }

    await storageService.saveUser(
      username: username,
      email: email,
      password: password,
    );
    await storageService.setLoggedIn(true);
    _showMessage('Account created successfully!');
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                ///  Title
                Text(
                  'Create Account',
                  style: AppFonts.notoBold(
                    color: Color(0xFFD64545),
                    fontSize: 32,
                  ),
                ),

                const SizedBox(height: 60),

                ///  Form
                Column(
                  children: [
                    InputFieldWidget(
                      hint: 'Username',
                      icon: Icons.person_outline,
                      controller: usernameController,
                    ),
                    SizedBox(height: 16),
                    InputFieldWidget(
                      hint: 'Email',
                      icon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    SizedBox(height: 16),
                    InputFieldWidget(
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 16),
                    InputFieldWidget(
                      hint: 'Confirm Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: confirmPasswordController,
                    ),
                    SizedBox(height: 28),

                    ///  Sign Up Button
                    MainButtonWidget(text: 'Sign Up', onPressed: _signUp),
                  ],
                ),

                const SizedBox(height: 24),

                ///  Back to login
                LoginTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
