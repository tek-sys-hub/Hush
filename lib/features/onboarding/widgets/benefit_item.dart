import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BenefitItem extends StatelessWidget {
  final String title;

  const BenefitItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_rounded,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
