import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/phone_status_bar.dart';
import 'widgets/benefit_item.dart';

class StarterPackageScreen extends StatelessWidget {
  final VoidCallback? onContinue;
  final VoidCallback? onBack;

  const StarterPackageScreen({
    super.key,
    this.onContinue,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const PhoneStatusBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Shield Badge
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundBadge,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shield_rounded,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Header Title & Subtitle
                    const Text(
                      'Starter Package',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Get the most out of Hush\nwith the starter package.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Starter Package Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCard,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        children: [
                          // Crown in circle
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundBadge,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.workspace_premium_rounded,
                                size: 26,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Starter Package',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Benefits
                          const BenefitItem(title: 'Lock unlimited apps'),
                          const BenefitItem(title: 'Use a custom PIN'),
                          const BenefitItem(title: 'Hide app notifications'),
                          const BenefitItem(title: 'Lightweight & fast'),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Continue Button
                    AppButton(
                      text: 'Continue',
                      onPressed: onContinue,
                    ),
                    const SizedBox(height: 20),

                    // Page Indicator Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDot(isActive: false),
                        const SizedBox(width: 8),
                        _buildDot(isActive: true),
                        const SizedBox(width: 8),
                        _buildDot(isActive: false),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.divider,
        shape: BoxShape.circle,
      ),
    );
  }
}
