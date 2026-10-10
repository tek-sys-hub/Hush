import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PhoneStatusBar extends StatelessWidget {
  final Color contentColor;

  const PhoneStatusBar({
    super.key,
    this.contentColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: contentColor,
              letterSpacing: -0.2,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cellular signal
              Icon(Icons.signal_cellular_4_bar, size: 16, color: contentColor),
              const SizedBox(width: 5),
              // Wifi icon
              Icon(Icons.wifi, size: 16, color: contentColor),
              const SizedBox(width: 5),
              // Battery icon
              Icon(Icons.battery_full_rounded, size: 19, color: contentColor),
            ],
          ),
        ],
      ),
    );
  }
}
