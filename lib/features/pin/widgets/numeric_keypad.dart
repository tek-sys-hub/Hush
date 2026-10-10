import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onDeletePressed;

  const NumericKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 16),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 16),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 16),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) => _buildDigitButton(digit)).toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Empty space for layout balance
        const SizedBox(width: 72, height: 72),

        // '0' button
        _buildDigitButton('0'),

        // Backspace button (taupe rounded container with white x)
        _buildBackspaceButton(),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.backgroundKeypad,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: AppColors.primary.withValues(alpha: 0.15),
          onTap: () => onDigitPressed(digit),
          child: Center(
            child: Text(
              digit,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Center(
        child: Container(
          width: 38,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              onTap: onDeletePressed,
              child: const Center(
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
