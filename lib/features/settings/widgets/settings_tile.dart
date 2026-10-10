import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                // Icon in soft circular badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundBadge,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 22,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Item Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                // Trailing Chevron
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
