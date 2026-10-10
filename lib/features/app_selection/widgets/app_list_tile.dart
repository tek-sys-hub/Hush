import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/app_info.dart';

class AppListTile extends StatelessWidget {
  final AppInfo app;
  final ValueChanged<bool> onToggle;

  const AppListTile({
    super.key,
    required this.app,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          // App icon container
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: app.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                app.icon,
                color: app.iconColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // App Name
          Expanded(
            child: Text(
              app.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Custom styled Toggle Switch
          Switch(
            value: app.isLocked,
            onChanged: onToggle,
            activeTrackColor: AppColors.primary,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.toggleInactive,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
