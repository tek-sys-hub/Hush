import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../core/widgets/phone_status_bar.dart';
import 'models/app_info.dart';
import 'widgets/app_list_tile.dart';

class SelectAppsScreen extends StatefulWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;

  const SelectAppsScreen({
    super.key,
    this.onNext,
    this.onBack,
  });

  @override
  State<SelectAppsScreen> createState() => _SelectAppsScreenState();
}

class _SelectAppsScreenState extends State<SelectAppsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<AppInfo> _allApps;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _allApps = [
      AppInfo(
        id: 'whatsapp',
        name: 'WhatsApp',
        icon: Icons.chat_bubble_rounded,
        iconColor: const Color(0xFF25D366),
        iconBgColor: const Color(0xFFE8F5E9),
        isLocked: true,
      ),
      AppInfo(
        id: 'instagram',
        name: 'Instagram',
        icon: Icons.camera_alt_rounded,
        iconColor: const Color(0xFFC13584),
        iconBgColor: const Color(0xFFFCE4EC),
        isLocked: true,
      ),
      AppInfo(
        id: 'facebook',
        name: 'Facebook',
        icon: Icons.facebook,
        iconColor: const Color(0xFF1877F2),
        iconBgColor: const Color(0xFFE3F2FD),
        isLocked: false,
      ),
      AppInfo(
        id: 'gmail',
        name: 'Gmail',
        icon: Icons.mail_rounded,
        iconColor: const Color(0xFFEA4335),
        iconBgColor: const Color(0xFFFFEBEE),
        isLocked: true,
      ),
      AppInfo(
        id: 'gallery',
        name: 'Gallery',
        icon: Icons.photo_library_rounded,
        iconColor: const Color(0xFF4CAF50),
        iconBgColor: const Color(0xFFE8F5E9),
        isLocked: false,
      ),
      AppInfo(
        id: 'notes',
        name: 'Notes',
        icon: Icons.description_rounded,
        iconColor: const Color(0xFF8D7362),
        iconBgColor: const Color(0xFFEDE5DC),
        isLocked: false,
      ),
      AppInfo(
        id: 'chrome',
        name: 'Chrome',
        icon: Icons.language_rounded,
        iconColor: const Color(0xFF4285F4),
        iconBgColor: const Color(0xFFE8EAF6),
        isLocked: true,
      ),
      AppInfo(
        id: 'youtube',
        name: 'YouTube',
        icon: Icons.play_arrow_rounded,
        iconColor: const Color(0xFFFF0000),
        iconBgColor: const Color(0xFFFFEBEE),
        isLocked: false,
      ),
      AppInfo(
        id: 'telegram',
        name: 'Telegram',
        icon: Icons.send_rounded,
        iconColor: const Color(0xFF2AABEE),
        iconBgColor: const Color(0xFFE1F5FE),
        isLocked: false,
      ),
      AppInfo(
        id: 'spotify',
        name: 'Spotify',
        icon: Icons.music_note_rounded,
        iconColor: const Color(0xFF1DB954),
        iconBgColor: const Color(0xFFE8F8F0),
        isLocked: false,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppInfo> get _filteredApps {
    if (_searchQuery.trim().isEmpty) return _allApps;
    return _allApps
        .where((app) =>
            app.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const PhoneStatusBar(),

            // Top Navigation & Title Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomBackButton(onPressed: widget.onBack),
                  const Spacer(),
                ],
              ),
            ),

            // Header Titles
            const Text(
              'Select Apps',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose the apps you want to lock.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSearch,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: AppColors.iconMuted,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search apps',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 18,
                          color: AppColors.iconMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // App List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                itemCount: _filteredApps.length,
                itemBuilder: (context, index) {
                  final app = _filteredApps[index];
                  return AppListTile(
                    app: app,
                    onToggle: (val) {
                      setState(() {
                        app.isLocked = val;
                      });
                    },
                  );
                },
              ),
            ),

            // Bottom "Next" Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: AppButton(
                text: 'Next',
                onPressed: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
