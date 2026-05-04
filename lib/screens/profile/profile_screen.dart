import 'package:flutter/material.dart';
import 'package:evently/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final String? profileImage;
  final bool isDarkMode;
  final String selectedLanguage;
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLanguage;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    this.profileImage,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onToggleTheme,
    required this.onToggleLanguage,
    required this.onLogout,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2A2A2A)
                        : Colors.grey[200],
                    image:
                        widget.profileImage != null &&
                            widget.profileImage!.isNotEmpty
                        ? DecorationImage(
                            image: widget.profileImage!.startsWith('assets/')
                                ? AssetImage(widget.profileImage!)
                                : NetworkImage(widget.profileImage!)
                                      as ImageProvider,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      widget.profileImage == null ||
                          widget.profileImage!.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 60,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkTextSecondary
                              : Colors.grey,
                        )
                      : null,
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0E3A99),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Profile Avatar
            const SizedBox(height: 24),

            // User Name
            Text(
              widget.userName ?? 'User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkText
                    : Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),

            // User Email
            Text(
              widget.userEmail ?? 'user@example.com',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextSecondary
                    : Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 40),

            // Dark Mode Toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2A2A2A)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF457AED)
                      : const Color(0xFFF0F0F0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkText
                          : Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: widget.isDarkMode,
                      onChanged: (_) => widget.onToggleTheme(),
                      activeColor: AppColors.darkButton,
                      inactiveThumbColor: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Language Option
            GestureDetector(
              onTap: widget.onToggleLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF457AED)
                        : const Color(0xFFF0F0F0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkText
                            : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.selectedLanguage,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkTextSecondary
                                : Colors.grey[600],
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkTextSecondary
                              : Colors.grey[600],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Logout Button
            GestureDetector(
              onTap: widget.onLogout,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF457AED)
                        : const Color(0xFFF0F0F0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkText
                            : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Icon(
                      Icons.logout,
                      size: 20,
                      color: const Color(0xFFE74C3C),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
