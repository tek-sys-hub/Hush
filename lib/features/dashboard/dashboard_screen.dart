import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/phone_status_bar.dart';
import 'widgets/locked_app_item.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onOpenSettings;
  final VoidCallback? onOpenSelectApps;
  final void Function(String appName, IconData icon)? onSelectAppToUnlock;

  const DashboardScreen({
    super.key,
    this.onOpenSettings,
    this.onOpenSelectApps,
    this.onSelectAppToUnlock,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> lockedApps = [
      {'name': 'WhatsApp', 'icon': Icons.chat_bubble_rounded},
      {'name': 'Instagram', 'icon': Icons.camera_alt_rounded},
      {'name': 'Facebook', 'icon': Icons.facebook},
      {'name': 'Gmail', 'icon': Icons.mail_rounded},
      {'name': 'Gallery', 'icon': Icons.photo_library_rounded},
      {'name': 'Notes', 'icon': Icons.description_rounded},
      {'name': 'Chrome', 'icon': Icons.language_rounded},
      {'name': 'YouTube', 'icon': Icons.play_arrow_rounded},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const PhoneStatusBar(),

            // Top Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hush',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Your apps, your privacy',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Settings Gear Button
                  IconButton(
                    onPressed: onOpenSettings,
                    splashRadius: 24,
                    icon: const Icon(
                      Icons.settings_rounded,
                      size: 24,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Center Lock Status Section
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.backgroundBadge,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_rounded,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // "Apps Locked" Pill Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.backgroundBadge,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Apps Locked',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Text(
              'Stay safe. Stay private.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

            const Spacer(),

            // Locked Apps Card Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Card Header with chevron
                    GestureDetector(
                      onTap: onOpenSelectApps,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Locked Apps',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2x4 Apps Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lockedApps.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final app = lockedApps[index];
                        return LockedAppItem(
                          name: app['name'] as String,
                          icon: app['icon'] as IconData,
                          onTap: () {
                            if (onSelectAppToUnlock != null) {
                              onSelectAppToUnlock!(
                                app['name'] as String,
                                app['icon'] as IconData,
                              );
                            }
                          },
                        );
                      },
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
