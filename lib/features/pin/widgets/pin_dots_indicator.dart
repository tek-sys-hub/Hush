import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PinDotsIndicator extends StatelessWidget {
  final int pinLength;
  final int totalDigits;
  final bool hasError;

  const PinDotsIndicator({
    super.key,
    required this.pinLength,
    this.totalDigits = 4,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDigits, (index) {
        final isFilled = index < pinLength;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasError
                ? Colors.redAccent
                : isFilled
                    ? AppColors.primary
                    : Colors.transparent,
            border: Border.all(
              color: hasError
                  ? Colors.redAccent
                  : AppColors.primary,
              width: 1.6,
            ),
          ),
        );
      }),
    );
  }
}
