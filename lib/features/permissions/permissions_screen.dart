import 'package:flutter/material.dart';
import '../../core/services/permission_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/custom_back_button.dart';

class PermissionsScreen extends StatefulWidget {
  final VoidCallback? onContinue;
  final VoidCallback? onBack;

  const PermissionsScreen({
    super.key,
    this.onContinue,
    this.onBack,
  });

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with WidgetsBindingObserver {
  bool _hasUsageStats = false;
  bool _hasOverlay = false;
  bool _hasNotification = false;
  bool _hasDeviceAdmin = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  Future<void> _checkPermissions() async {
    final usage = await PermissionService.checkUsageStats();
    final overlay = await PermissionService.checkOverlay();
    final notif = await PermissionService.checkNotification();
    final admin = await PermissionService.checkDeviceAdmin();

    if (mounted) {
      setState(() {
        _hasUsageStats = usage;
        _hasOverlay = overlay;
        _hasNotification = notif;
        _hasDeviceAdmin = admin;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomBackButton(onPressed: widget.onBack),
                  const Spacer(),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Header Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundBadge,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.security_rounded,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    const Text(
                      'App Locker Permissions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      'Hush requires system permissions on your phone to detect when locked apps open, present the lock screen, and prevent unauthorized uninstallation.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Permission Items List
                    Expanded(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : ListView(
                              children: [
                                _buildPermissionTile(
                                  icon: Icons.insights_rounded,
                                  title: 'Usage Access',
                                  subtitle:
                                      'Detects when a locked app is launched.',
                                  isGranted: _hasUsageStats,
                                  onRequest: () async {
                                    await PermissionService
                                        .requestUsageStats();
                                  },
                                ),
                                const SizedBox(height: 14),
                                _buildPermissionTile(
                                  icon: Icons.layers_rounded,
                                  title: 'Display Over Other Apps',
                                  subtitle:
                                      'Shows the lock screen on top of protected apps.',
                                  isGranted: _hasOverlay,
                                  onRequest: () async {
                                    await PermissionService.requestOverlay();
                                  },
                                ),
                                const SizedBox(height: 14),
                                _buildPermissionTile(
                                  icon: Icons.notifications_active_rounded,
                                  title: 'Notifications & Service',
                                  subtitle:
                                      'Keeps app locker active in background.',
                                  isGranted: _hasNotification,
                                  onRequest: () async {
                                    await PermissionService
                                        .requestNotification();
                                  },
                                ),
                                const SizedBox(height: 14),
                                _buildPermissionTile(
                                  icon: Icons.admin_panel_settings_rounded,
                                  title: 'Uninstall Protection',
                                  subtitle:
                                      'Prevents Hush from being uninstalled without permission.',
                                  isGranted: _hasDeviceAdmin,
                                  onRequest: () async {
                                    await PermissionService
                                        .requestDeviceAdmin();
                                  },
                                ),
                              ],
                            ),
                    ),

                    // Bottom Continue Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 12.0),
                      child: AppButton(
                        text: 'Continue',
                        onPressed: widget.onContinue,
                      ),
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

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isGranted,
    required VoidCallback onRequest,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.backgroundBadge,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          isGranted
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_rounded,
                          size: 14, color: Colors.green.shade700),
                      const SizedBox(width: 4),
                      Text(
                        'Allowed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                )
              : ElevatedButton(
                  onPressed: onRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Grant'),
                ),
        ],
      ),
    );
  }
}
