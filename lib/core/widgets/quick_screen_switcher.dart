import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QuickScreenSwitcher extends StatelessWidget {
  final int currentScreenIndex;
  final ValueChanged<int> onSelectScreen;

  const QuickScreenSwitcher({
    super.key,
    required this.currentScreenIndex,
    required this.onSelectScreen,
  });

  static final List<String> screenNames = [
    '1. Splash / Welcome',
    '2. Starter Package',
    '3. Select Apps',
    '4. Set Password',
    '5. Confirm Password',
    '6. App Locker Dashboard',
    '7. Settings',
    '8. WhatsApp Locked Screen',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Jump to any UI Screen (from ui.png)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: screenNames.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (context, index) {
                final isSelected = index == currentScreenIndex;
                return ListTile(
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: isSelected ? AppColors.backgroundBadge : null,
                  leading: CircleAvatar(
                    radius: 14,
                    backgroundColor: isSelected ? AppColors.primary : AppColors.backgroundCard,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  title: Text(
                    screenNames[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded, color: AppColors.primary, size: 20)
                      : null,
                  onTap: () {
                    onSelectScreen(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
