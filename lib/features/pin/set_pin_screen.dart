import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_back_button.dart';
import 'widgets/numeric_keypad.dart';
import 'widgets/pin_dots_indicator.dart';

class SetPinScreen extends StatefulWidget {
  final ValueChanged<String>? onPinEntered;
  final VoidCallback? onBack;

  const SetPinScreen({
    super.key,
    this.onPinEntered,
    this.onBack,
  });

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String _currentPin = '';

  void _handleDigit(String digit) {
    if (_currentPin.length < 4) {
      setState(() {
        _currentPin += digit;
      });

      if (_currentPin.length == 4) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            widget.onPinEntered?.call(_currentPin);
          }
        });
      }
    }
  }

  void _handleDelete() {
    if (_currentPin.isNotEmpty) {
      setState(() {
        _currentPin = _currentPin.substring(0, _currentPin.length - 1);
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
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomBackButton(onPressed: widget.onBack),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Title & Subtitle
            const Text(
              'Set Your Password',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a 4-digit PIN to protect\nyour apps.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 36),

            // PIN Dots Indicator
            PinDotsIndicator(pinLength: _currentPin.length),

            const Spacer(),

            // Keypad
            NumericKeypad(
              onDigitPressed: _handleDigit,
              onDeletePressed: _handleDelete,
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
