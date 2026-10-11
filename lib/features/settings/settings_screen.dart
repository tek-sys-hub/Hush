import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_back_button.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onChangePin;
  final VoidCallback? onAppLock;
  final VoidCallback? onPermissions;

  const SettingsScreen({
    super.key,
    this.onBack,
    this.onChangePin,
    this.onAppLock,
    this.onPermissions,
  });

  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Hide sensitive preview content and app alerts on lock screen.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Hide notifications for locked apps'),
              value: true,
              activeTrackColor: AppColors.primary,
              activeThumbColor: Colors.white,
              onChanged: (val) {},
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showPrivacyInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy & Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Hush uses on-device encrypted storage to protect your private apps without transmitting any personal data externally.',
              style: TextStyle(fontSize: 14, height: 1.5, color: AppColors.textSecondary),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Hush v1.0.0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Minimalist, secure app locker crafted with Flutter.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Title Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomBackButton(onPressed: onBack),
                  const Spacer(),
                ],
              ),
            ),

            // Header Title
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    SettingsTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Change PIN',
                      onTap: onChangePin,
                    ),
                    SettingsTile(
                      icon: Icons.grid_view_rounded,
                      title: 'App Lock',
                      onTap: onAppLock,
                    ),
                    SettingsTile(
                      icon: Icons.security_rounded,
                      title: 'Permissions',
                      onTap: onPermissions,
                    ),
                    SettingsTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () => _showNotificationSettings(context),
                    ),
                    SettingsTile(
                      icon: Icons.shield_outlined,
                      title: 'Privacy',
                      onTap: () => _showPrivacyInfo(context),
                    ),
                    SettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      onTap: () => _showAboutDialog(context),
                    ),
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
