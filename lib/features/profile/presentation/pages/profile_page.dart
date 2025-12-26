import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/core/constants/app_fonts.dart';
import 'package:shop_easy/core/constants/app_routes.dart';
import 'package:shop_easy/core/services/local_storage_service.dart';
import 'package:shop_easy/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:shop_easy/features/profile/presentation/widgets/info_tile_widget.dart';
import 'package:shop_easy/features/auth/presentation/widgets/main_button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  Future<LocalStorageService> _getStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppFonts.notoBold(
            fontSize: 24,
            color: const Color(0xFFD64545),
          ),
        ),
      ),
      body: FutureBuilder<LocalStorageService>(
        future: _getStorage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final storage = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                /// Avatar with Edit Button
                Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD64545), Color(0xFFFF7F7F)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Text(
                        storage.username != null
                            ? storage.username![0].toUpperCase()
                            : '?',
                        style: AppFonts.notoBold(
                          fontSize: 40,
                          color: const Color(0xFFD64545),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => EditProfileDialog.show(context, storage),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFD64545),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /// Info Cards
                InfoTileWidget(
                  label: 'Username',
                  value: storage.username ?? '-',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                InfoTileWidget(
                  label: 'Email',
                  value: storage.email ?? '-',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                /// Logout Button
                MainButtonWidget(
                  text: 'Logout',
                  onPressed: () async {
                    await storage.setLoggedIn(false);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.loginPage,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
